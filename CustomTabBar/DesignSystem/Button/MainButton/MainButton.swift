import SwiftUI

public struct MainButton: View {
  let title: String
  let action: () -> ()
  var type: ButtonType = .primary
  var image: String?
  
  @Environment(\.isEnabled) private var isEnabled
  
  public var body: some View {
    switch type {
    case .primary:
      buttonContent
        .buttonStyle(PrimaryStyle(isEnabled: isEnabled))
    case .secondary:
      buttonContent
        .buttonStyle(SecondaryStyle(isEnabled: isEnabled))
    case .tertiary:
      buttonContent
        .buttonStyle(TertiaryStyle(isEnabled: isEnabled))
    }
  }
}
  
private extension MainButton {
  private var buttonContent: some View {
    Button(action: action) {
      HStack {
        if let image {
          Image(image)
        }
        Text(title)
      }
    }
  }
}

public extension MainButton {
  enum ButtonType {
    case primary
    case secondary
    case tertiary
  }
}

protocol MainButtonStyle: ButtonStyle {
  associatedtype BaseLabel: View
  func baseLabel(for configuration: ButtonStyle.Configuration) -> BaseLabel
}

extension MainButtonStyle {
  func baseLabel(for configuration: ButtonStyle.Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 16)
      .font(Styles.Fonts.bodyMedium)
      .frame(height: 48, alignment: .center)
      .frame(maxWidth: .infinity)
      .contentShape(
        RoundedRectangle(cornerRadius: 24)
      )
  }
}


enum Styles {
  enum Fonts {
    static let bodyMedium = Font.system(size: 16, weight: .medium)
    static let smallRegular = Font.system(size: 12, weight: .regular)
    static let headerRegular = Font.system(size: 14, weight: .regular)
  }
}
