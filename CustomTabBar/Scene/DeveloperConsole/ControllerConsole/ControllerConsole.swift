import ComposableArchitecture
import Foundation

struct ControllerConsole: ReducerProtocol {
  var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { _, _  in .none }
  }
}

extension ControllerConsole {
  struct State: Equatable {
    var firstController = ControllerState(
      selectedItems: [],
      items: ["Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum"].map(SelectableModel.init),
      type: .selectable
    )
    var secondController = ControllerState(
      selectedItems: [],
      items: ["Lorem ips", "Lorem ipsum23", "Lorem", "Lorem32", "Lorem4555", "Loremqipsum4535", "Lorem 23412", "ipsum", "Lorem3434ipsum"].map(SelectableModel.init),
      type: .selectable
    )
    var thirdController = ControllerState(
      selectedItems: [],
      items: ["Lorem ipsum1", "Lorem ipsum2"].map(SelectableModel.init),
      type: .segmentable(.two)
    )
    var fourthController = ControllerState(
      selectedItems: [],
      items: ["Lorem ipsum1", "Lorem ipsum2", "Lorem ipsum3"].map(SelectableModel.init),
      type: .segmentable(.three)
    )
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
  }
}

extension ControllerConsole {
  struct ControllerState: Equatable {
    @BindableState var selectedItems: [SelectableModel]
    let items: [SelectableModel]
    let type: ControllerType
    
    init(selectedItems: [SelectableModel], items: [SelectableModel], type: ControllerType) {
      self.items = items
      self.type = type
      
      guard selectedItems.isEmpty,
            type.isSegmentedControl,
            let firstItem = items.first
      else {
        self.selectedItems = selectedItems
        return
      }
      self.selectedItems = [firstItem]
    }
  }
}
