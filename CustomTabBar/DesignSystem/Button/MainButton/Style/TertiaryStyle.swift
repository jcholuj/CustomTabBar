import SwiftUI

struct TertiaryStyle: MainButtonStyle {
  let isEnabled: Bool
  
  func makeBody(configuration: Configuration) -> some View {
    baseLabel(for: configuration)
      .foregroundColor(
        isEnabled ? Constants.textColor : Constants.disabledTextColor
      )
      .opacity(configuration.isPressed ? 0.5 : 1)
  }
  
  private enum Constants {
    static let textColor = Color.blue
    static let disabledTextColor = Color.gray
  }
}

