import ComposableArchitecture
import Foundation

struct Controller: ReducerProtocol {
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case let .selectedItemsHasChanged(selectedItems):
      state.selectedItems = selectedItems
      return .none
    }
  }
}

extension Controller {
  struct State: Equatable {
    var selectedItems: [UUID]
    let items: [SelectableModel]
    let type: ControllerType
    
    init(selectedItems: [UUID], items: [SelectableModel], type: ControllerType) {
      self.items = items
      self.type = type
      
      guard selectedItems.isEmpty,
            type.isSegmentedControl,
            let firstItemId = items.first?.id
      else {
        self.selectedItems = selectedItems
        return
      }
      self.selectedItems = [firstItemId]
    }
  }
  
  enum Action: Equatable {
    case selectedItemsHasChanged([UUID])
  }
}

extension Controller.State {
  var segmentedItems: [SelectableModel] {
    Array(items.prefix(upTo: type.itemsCount))
  }
  
  var selectedItem: SelectableModel? {
    guard let selectedId = selectedItems.first else { return nil }
    return items.first { $0.id == selectedId }
  }
}
