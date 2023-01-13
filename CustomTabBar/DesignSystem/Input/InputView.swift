import SwiftUI

struct InputView: View {
  let type: InputType
  let title: String
  let placeholder: String
  var tooltipAction: (() -> ())? = nil
  
  @Binding var inputValue: String
  @Binding var isValid: Bool
  
  @State private var isFocused: Bool = false
  @State private var isSecured: Bool
  
  init(
    type: InputType,
    title: String,
    placeholder: String,
    inputValue: Binding<String>,
    isValid: Binding<Bool>,
    tooltipAction: (() -> Void)? = nil
  ) {
    self.type = type
    self.title = title
    self.placeholder = placeholder
    self.tooltipAction = tooltipAction
    self._inputValue = inputValue
    self._isValid = isValid
    isSecured = type == .secured
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: Constants.componentSpacing) {
      Text(title)
        .font(Styles.Fonts.headerRegular)
        .foregroundColor(.gray)
      HStack(spacing: Constants.textFieldSpacing) {
        if type.isSearchField {
          Image(Constants.searchIcon)
            .padding(.leading, Constants.leadingRegularPadding)
        }
        textField
        rightTooltipButton
      }
      .frame(height: Constants.textFieldHeight)
      .background(backgroundView)
      if !isValid {
        // TODO: - jcholuj 12/01/2023 - this should be configured via validator
        Text("Wpisz prawidłowe dane")
          .font(Styles.Fonts.smallRegular)
          .foregroundColor(.red)
      }
    }
    .frame(height: Constants.componentHeight)
    .animation(Constants.securedButtonAnimation, value: isSecured)
  }
}

// MARK: - Textfield builder

private extension InputView {
  @ViewBuilder
  private var textField: some View {
    // TODO: - SecuredField will be added in separate merge request
    TextField(
      placeholder,
      text: $inputValue,
      onEditingChanged: { isFocused = $0 }
    )
    .padding(.leading, Constants.leadingRegularPadding)
    .autocorrectionDisabled()
  }
}

// MARK: - Tooltip builder

private extension InputView {
  @ViewBuilder
  private var rightTooltipButton: some View {
    if !isValid {
      invalidTooltip
    } else if type == .secured {
      securedTooltipButton
    } else if isFocused {
      clearTooltipButton
    } else if let tooltipAction {
      IconButton(icon: Constants.infoIcon, action: tooltipAction)
    }
  }
  
  private var invalidTooltip: some View {
    IconButton(
      icon: Constants.errorIcon,
      action: {}
    )
    .disabled(true)
  }
  
  private var clearTooltipButton: some View {
    IconButton(icon: Constants.clearIcon) {
      inputValue = ""
    }
  }
  
  private var securedTooltipButton: some View {
    IconButton(
      icon: isSecured
        ? Constants.visibleIcon
        : Constants.invisibleIcon
    ) {
      isSecured.toggle()
    }
  }
}

// MARK: - Background builder

private extension InputView {
  @ViewBuilder
  private var backgroundView: some View {
    switch (isValid, isFocused) {
    case (false, _):
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .stroke(.red, lineWidth: Constants.unselectedBorderWidth)
    case (_, true):
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .stroke(.blue, lineWidth: Constants.selectedBorderWidth)
    default:
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .stroke(.gray, lineWidth: Constants.unselectedBorderWidth)
    }
  }
}

// MARK: - Constants

fileprivate enum Constants {
  static let searchIcon = "search"
  static let clearIcon = "clear"
  static let errorIcon = "error"
  static let infoIcon = "info"
  static let visibleIcon = "visible"
  static let invisibleIcon = "invisible"
  static let textFieldHeight: CGFloat = 56
  static let componentHeight: CGFloat = 100
  static let textFieldSpacing: CGFloat = 0
  static let componentSpacing: CGFloat = 4
  static let cornerRadius: CGFloat = 4
  static let selectedBorderWidth: CGFloat = 2
  static let unselectedBorderWidth: CGFloat = 1
  static let leadingRegularPadding: CGFloat = 16
  static let leadingSmallPadding: CGFloat = 14
  static let securedButtonAnimation: Animation = .linear(duration: 0.1)
}
