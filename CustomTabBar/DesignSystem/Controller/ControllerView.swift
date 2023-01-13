import ComposableArchitecture
import SwiftUI

struct ControllerView: View {
  private let items: [SelectableModel]
  private let type: ControllerType
  private let screenWidth: CGFloat
  private var dataDividedIntoLines: [[SelectableModel]] = []
  
  @Binding private var selectedItems: [SelectableModel]
  
  init(
    items: [SelectableModel],
    type: ControllerType,
    screenWidth: CGFloat,
    selectedItems: Binding<[SelectableModel]>
  ) {
    self.items = items
    self.type = type
    self.screenWidth = screenWidth
    self._selectedItems = selectedItems
    dataDividedIntoLines = divideDataIntoLines(lineWidth: screenWidth)
  }

  var body: some View {
    switch type {
    case .selectable:
      filterController
    case .segmentable:
      segmentedController
    }
  }
  
  @ViewBuilder
  private var segmentedController: some View {
    HStack {
      HStack(spacing: 0) {
        ForEach(
          Array(
            segmentedItems
          )
        ) { item in
          ControllerItemView(
            model: item,
            type: type,
            selectedItems: $selectedItems,
            isSelected: selectedItems.contains(item)
          )
        }
      }
      .frame(maxWidth: .infinity)
    }
    .padding(2)
    .background(.gray.opacity(0.3))
    .clipShape(RoundedRectangle(cornerRadius: Constants.backgroundHeight))
  }
  
  @ViewBuilder
  private var filterController: some View {
    VStack(alignment: .leading, spacing: Constants.itemsVerticalSpacing) {
      ForEach(
        dataDividedIntoLines
          .map { (data: $0, id: UUID()) },
        id: \.id
      ) { dataArray in
        Group {
          HStack(spacing: Constants.itemsHorizontalSpacing) {
            ForEach(dataArray.data, id: \.id) { data in
              ControllerItemView(
                model: data,
                type: .selectable,
                selectedItems: $selectedItems,
                isSelected: selectedItems.contains(data)
              )
            }
          }
        }
      }
    }
    .frame(
      width: screenWidth,
      height: calculateVStackHeight(width: screenWidth)
    )
  }
  
  private func divideDataIntoLines(lineWidth: CGFloat) -> [[SelectableModel]] {
    let data = calculateWidths(for: items)
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
  
  private func calculateVStackHeight(width: CGFloat) -> CGFloat {
    (Constants.itemsVerticalSpacing + Constants.controllerItemHeight) * CGFloat(dataDividedIntoLines.count)
  }
}

private extension ControllerView {
  var segmentedItems: [SelectableModel] {
    Array(items.prefix(upTo: type.itemsCount))
  }
}

struct ControllerView_Previews: PreviewProvider {
  static var previews: some View {
    ControllerView(
      items: [
        "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum"
      ].map { SelectableModel(displayedName: $0) },
      type: .selectable,
      screenWidth: 375,
      selectedItems: .constant([])
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
