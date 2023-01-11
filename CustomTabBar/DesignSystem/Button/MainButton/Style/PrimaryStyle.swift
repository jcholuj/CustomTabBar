import SwiftUI

struct PrimaryStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    PrimaryButton(configuration: configuration)
  }
  
  private struct PrimaryButton: View {
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
            .fill(
              isEnabled
              ? Constants.backgroundColor
              : Constants.disabledBackgroundColor
            )
        )
    }
  }
  
  private enum Constants {
    static let textColor = Color.white
    static let backgroundColor = Color.blue
    static let disabledTextColor = Color.gray
    static let disabledBackgroundColor = Color.gray.opacity(0.25)
    static let cornerRadius: CGFloat = 24
  }
}

