import SwiftUI

extension View {
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
