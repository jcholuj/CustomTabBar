import SwiftUI

// TODO: - jcholuj - 07.01.2022
/// Check if DesignSystem needs to be used on platform lower than iOS 15.0, because it will has an impact on implementation of custom placeholder color

struct InputView: View {
  let type: InputType
  
  @Binding var inputValue: String
  @Binding var isValid: Bool
  @Binding var isFocused: Bool

  @State var isSecured: Bool
  
  var body: some View {
    VStack(alignment: .leading, spacing: Constants.componentSpacing) {
      Text(type.title)
        .font(Styles.Fonts.headerRegular)
        .foregroundColor(.gray)
      HStack(spacing: Constants.textFieldSpacing) {
        if type.isSearchField {
          Image(Constants.searchIcon)
            .padding(.leading, Constants.leadingRegularPadding)
        }
        textField
        rightTextfieldItem
      }
      .frame(height: Constants.textFieldHeight)
      .background(backgroundView)
      if !isValid {
        Text(type.validationMessage)
          .font(Styles.Fonts.smallRegular)
          .foregroundColor(.red)
      }
    }
    .frame(height: Constants.componentHeight)
    .animation(.linear(duration: 0.1), value: isSecured)
  }
}

// MARK: - Textfield builder

private extension InputView {
  @ViewBuilder
  private var textField: some View {
    ZStack {
      SecureField(type.placeholder, text: $inputValue)
        .padding(
          .leading,
          type.isSearchField
          ? Constants.leadingSmallPadding
          : Constants.leadingRegularPadding
        )
        .opacity(isSecured ? 1.0 : 0.0)
      TextField(
        type.placeholder,
        text: $inputValue,
        onEditingChanged: { isFocused = $0 }
      )
      .padding(
        .leading,
        type.isSearchField
        ? Constants.leadingSmallPadding
        : Constants.leadingRegularPadding
      )
      .foregroundColor(isSecured ? .clear : .black)
      .tint(isSecured ? .clear : .black)
      .autocorrectionDisabled()
    }
  }
}

// MARK: - Tooltip builder

private extension InputView {
  @ViewBuilder
  private var rightTextfieldItem: some View {
    if let tooltipIcon {
      IconButton(icon: tooltipIcon) {
        guard type != .password else {
          isSecured.toggle()
          return
        }
        guard !isFocused else {
          inputValue = ""
          return
        }
        // TODO: - jcholuj - 07.01.2022
        /// Add handling tooltip action
      }
      .disabled(!isValid)
    }
  }
  
  private var tooltipIcon: String? {
    guard type != .password else {
      return isSecured ? Constants.visibleIcon : Constants.invisibleIcon
    }
    switch (isValid, isFocused, type.hasTooltip) {
    case (false, _, _):
      return Constants.errorIcon
    case (true, true, _):
      return Constants.clearIcon
    case (true, false, true):
      return Constants.infoIcon
    default:
      return nil
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

private extension InputView {
  enum Constants {
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
  }
}
