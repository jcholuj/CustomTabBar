import SwiftUI

struct SecondaryStyle: MainButtonStyle {
  let isEnabled: Bool
  
  func makeBody(configuration: Configuration) -> some View {
    baseLabel(for: configuration)
      .foregroundColor(
        isEnabled
        ? Constants.textColor
        : Constants.disabledTextColor
      )
      .background(
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .stroke(
            isEnabled
            ? Constants.borderColor
            : Constants.disabledBorderColor,
            lineWidth: Constants.borderWidth
          )
      )
      .opacity(configuration.isPressed ? 0.5 : 1)
  }
  
  private enum Constants {
    static let textColor = Color.blue
    static let disabledTextColor = Color.gray
    static let disabledBorderColor = Color.gray
    static let borderColor = Color.blue
    static let borderWidth: CGFloat = 1
    static let cornerRadius: CGFloat = 24
  }
}

