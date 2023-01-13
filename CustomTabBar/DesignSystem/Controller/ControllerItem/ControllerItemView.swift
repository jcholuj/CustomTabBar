import SwiftUI

struct ControllerItemView: View {
  let model: SelectableModel
  let type: ControllerType
  var icon: String? = nil
  
  @Binding var selectedItems: [SelectableModel]
  @State var isSelected: Bool

  var body: some View {
    baseView
      .onChange(of: selectedItems) { newValue in
        isSelected = newValue.contains(model)
      }
      .onTapGesture {
        handleTapGesture(with: model)
      }
  }
  
  @ViewBuilder
  private var controllerText: some View {
    Text(model.displayedName)
      .font(Constants.font)
      .foregroundColor(.blueSelected)
      .lineLimit(1)
      .contentShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
  }
  
  @ViewBuilder
  private var baseView: some View {
    HStack {
      if let icon, type.hasIcon {
        Image(icon)
      }
      if type == .selectable {
        controllerText
      } else {
        controllerText
          .frame(maxWidth: .infinity)
      }
    }
    .contentShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    .padding(.horizontal, type.horizontalPadding)
    .frame(height: Constants.componentHeight)
    .background(backgroundView)
  }
  
  var backgroundView: some View {
    RoundedRectangle(cornerRadius: Constants.cornerRadius)
      .fill(backgroundColor)
  }
  
  private var backgroundColor: Color {
    switch (isSelected, type) {
    case (true, .selectable):
      return .blueBackground
    case (true, .segmentable):
      return Constants.backgroundColor
    case (false, _):
      return .clear
    }
  }
  
  private func handleTapGesture(with model: SelectableModel) {
    guard !type.isSegmentedControl else {
      selectedItems = [model]
      return
    }
    
    if selectedItems.contains(model) {
      selectedItems.removeAll { $0 == model }
    } else {
      selectedItems.append(model)
    }
  }
}

// MARK: - Constants

private extension ControllerItemView {
  enum Constants {
    static let font: Font = .system(size: 14, weight: .semibold)
    static let componentHeight: CGFloat = 32
    static let cornerRadius: CGFloat = componentHeight / 2
    static let backgroundColor = Color.white
  }
}
