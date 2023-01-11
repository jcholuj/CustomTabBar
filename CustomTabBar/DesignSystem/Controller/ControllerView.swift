import ComposableArchitecture
import SwiftUI

struct ControllerView: View {
  private let store: Store<Controller.State, Controller.Action>
  private let screenWidth: CGFloat
  private var dataDividedIntoLines: [[SelectableModel]] = []
  
  init(store: Store<Controller.State, Controller.Action>, screenWidth: CGFloat) {
    self.store = store
    self.screenWidth = screenWidth
  }

  var body: some View {
    HStack {
      WithViewStore(store, observe: { $0 }) { viewStore in
        switch viewStore.state.type {
        case .selectable:
          filterController(viewStore: viewStore)
        case .segmentable:
          segmentedController(viewStore: viewStore)
        }
      }
    }
  }
  
  @ViewBuilder
  private func segmentedController(
    viewStore: ViewStore<Controller.State, Controller.Action>
  ) -> some View {
    HStack {
      HStack(spacing: 0) {
        ForEach(
          Array(
            viewStore.state.segmentedItems
          )
        ) { item in
          ControllerItemView(
            model: item,
            type: viewStore.state.type,
            selectedItems: viewStore.binding(
              get: \.selectedItems,
              send: Controller.Action.selectedItemsHasChanged
            ),
            isSelected: viewStore.state.selectedItems.contains(item.id)
          )
          //.frame(maxWidth: .infinity)
        }
      }
      .frame(maxWidth: .infinity)
    }
    .padding(2)
    .background(.gray.opacity(0.3))
    .clipShape(RoundedRectangle(cornerRadius: Constants.backgroundHeight))
  }
  
  @ViewBuilder
  private func filterController(
    viewStore: ViewStore<Controller.State, Controller.Action>
  ) -> some View {
    VStack(alignment: .leading, spacing: Constants.itemsVerticalSpacing) {
      ForEach(
        divideDataIntoLines(lineWidth: screenWidth, viewStore: viewStore)
          .map { (data: $0, id: UUID()) },
        id: \.id
      ) { dataArray in
        Group {
          HStack(spacing: Constants.itemsHorizontalSpacing) {
            ForEach(dataArray.data, id: \.id) { data in
              ControllerItemView(
                model: data,
                type: .selectable,
                selectedItems: viewStore.binding(get: \.selectedItems, send: Controller.Action.selectedItemsHasChanged),
                isSelected: viewStore.state.selectedItems.contains(data.id)
              )
            }
          }
        }
      }
    }
    .frame(
      width: screenWidth,
      height: calculateVStackHeight(width: screenWidth, viewStore: viewStore)
    )
  }
  
  private func divideDataIntoLines(
    lineWidth: CGFloat,
    viewStore: ViewStore<Controller.State, Controller.Action>
  ) -> [[SelectableModel]] {
    let data = calculateWidths(for: viewStore.state.items)
    var singleLineWidth = lineWidth
    var allLinesResult = [[SelectableModel]]()
    var singleLineResult = [SelectableModel]()
    var partialWidthResult: CGFloat = 0
    
    data.forEach { (selectableType, width) in
      partialWidthResult = singleLineWidth - width
      if partialWidthResult > 0 {
        singleLineResult.append(selectableType)
        singleLineWidth -= width
      } else {
        allLinesResult.append(singleLineResult)
        singleLineResult = [selectableType]
        singleLineWidth = lineWidth - width
      }
    }
    
    guard !singleLineResult.isEmpty else { return allLinesResult }
    allLinesResult.append(singleLineResult)
    return allLinesResult
  }
  
  private func calculateWidths(for data: [SelectableModel]) -> [(value: SelectableModel, width: CGFloat)] {
    return data.map { selectableType -> (SelectableModel, CGFloat) in
      let textWidth = selectableType.displayedName.getWidth(with: Constants.font)
      let width = [Constants.textPadding, Constants.textPadding, Constants.itemsHorizontalSpacing]
        .reduce(textWidth, +)
      return (selectableType, width)
    }
  }
  
  private func calculateVStackHeight(
    width: CGFloat,
    viewStore: ViewStore<Controller.State, Controller.Action>
  ) -> CGFloat {
    let dataDividedIntoLines = divideDataIntoLines(lineWidth: width, viewStore: viewStore)
    return (Constants.itemsVerticalSpacing + Constants.controllerItemHeight) * CGFloat(dataDividedIntoLines.count)
  }
}

struct ControllerView_Previews: PreviewProvider {
  static var previews: some View {
    ControllerView(
      store: Store(
        initialState: Controller.State(
          selectedItems: [],
          items: [
            "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum"
          ].map { SelectableModel(displayedName: $0) },
          type: .selectable
        ),
        reducer: Controller()
      ),
      screenWidth: 375
    )
  }
}

struct SelectableModel: Identifiable, Equatable {
  static func == (lhs: SelectableModel, rhs: SelectableModel) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
  
  var displayedName: String
  let id: UUID = UUID()
}

extension String {
  func getWidth(with font: UIFont) -> CGFloat {
    let fontAttributes = [NSAttributedString.Key.font: font]
    let size = self.size(withAttributes: fontAttributes)
    return size.width
  }
  
  func getHeight(with font: UIFont) -> CGFloat {
    let fontAttributes = [NSAttributedString.Key.font: font]
    let size = self.size(withAttributes: fontAttributes)
    return size.height
  }
}

private extension ControllerView {
  enum Constants {
    static let font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let controllerItemHeight: CGFloat = 32
    static let backgroundHeight: CGFloat = 36
    static let itemsVerticalSpacing: CGFloat = 16
    static let itemsHorizontalSpacing: CGFloat = 4
    static let textPadding: CGFloat = 8
  }
}
