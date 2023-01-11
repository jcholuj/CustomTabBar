import SwiftUI

public struct MainButton: View {
  public enum ButtonType {
    case primary
    case secondary
    case tertiary
  }
  
  let type: ButtonType
  let title: String
  let image: String?
  let action: () -> ()
  
  public init(
    title: String,
    image: String? = nil,
    type: ButtonType = .primary,
    action: @escaping () -> ()
  ) {
    self.title = title
    self.image = image
    self.type = type
    self.action = action
  }
  
  public var body: some View {
    switch type {
    case .primary:
      buttonContent
        .buttonStyle(Styles.Buttons.primary)
    case .secondary:
      buttonContent
        .buttonStyle(Styles.Buttons.secondary)
    case .tertiary:
      buttonContent
        .buttonStyle(Styles.Buttons.tertiary)
    }
  }
  
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

enum Styles {
  enum Fonts {
    static let bodyMedium = Font.system(size: 16, weight: .medium)
    static let smallRegular = Font.system(size: 12, weight: .regular)
    static let headerRegular = Font.system(size: 14, weight: .regular)
  }
  
  enum Buttons {
    static let primary = PrimaryStyle()
    static let secondary = SecondaryStyle()
    static let tertiary = TertiaryStyle()
  }
}

