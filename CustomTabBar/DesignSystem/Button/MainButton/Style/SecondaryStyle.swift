import SwiftUI

struct SecondaryStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    SecondaryButton(configuration: configuration)
  }
  
  private struct SecondaryButton: View {
    let configuration: ButtonStyle.Configuration
    
    @Environment(\.isEnabled) private var isEnabled
    
    var body: some View {
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
    }
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

