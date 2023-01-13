import SwiftUI

struct PrimaryStyle: MainButtonStyle {
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
          .fill(
            isEnabled
            ? Constants.backgroundColor
            : Constants.disabledBackgroundColor
          )
      )
      .opacity(configuration.isPressed ? 0.5 : 1)
  }
  
  private enum Constants {
    static let textColor = Color.white
    static let backgroundColor = Color.blue
    static let disabledTextColor = Color.gray
    static let disabledBackgroundColor = Color.gray.opacity(0.25)
    static let cornerRadius: CGFloat = 24
  }
}

