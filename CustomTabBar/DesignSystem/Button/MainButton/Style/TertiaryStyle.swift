import SwiftUI

struct TertiaryStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    TertiaryButton(configuration: configuration)
  }
  
  private struct TertiaryButton: View {
    let configuration: ButtonStyle.Configuration
    
    @Environment(\.isEnabled) private var isEnabled
    
    var body: some View {
      baseLabel(for: configuration)
        .foregroundColor(
          isEnabled ? Constants.textColor : Constants.disabledTextColor
        )
    }
  }
  
  private enum Constants {
    static let textColor = Color.blue
    static let disabledTextColor = Color.gray
  }
}

