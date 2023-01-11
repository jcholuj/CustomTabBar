import ComposableArchitecture
import SwiftUI

struct ControllerConsoleView: View {
  let store: StoreOf<ControllerConsole>
  
  var body: some View {
    GeometryReader { geo in
      WithViewStore(store, observe: { $0 }) { viewStore in
        VStack(spacing: 20) {
          ControllerView(
            store: store.scope(
              state: \.firstController,
              action: ControllerConsole.Action.firstControllerAction
            ),
            screenWidth: geo.size.width
          )
          Text("Selected items count: \(viewStore.firstController.selectedItems.count)")
          ControllerView(
            store: store.scope(
              state: \.secondController,
              action: ControllerConsole.Action.secondControllerAction
            ),
            screenWidth: geo.size.width
          )
          Text("Selected items count: \(viewStore.secondController.selectedItems.count)")
          ControllerView(
            store: store.scope(
              state: \.thirdController,
              action: ControllerConsole.Action.thirdControllerAction
            ),
            screenWidth: geo.size.width
          )
          if let item = viewStore.thirdController.selectedItem {
            Text("Selected status: \(item.displayedName)")
          }
          ControllerView(
            store: store.scope(
              state: \.fourthController,
              action: ControllerConsole.Action.fourthControllerAction
            ),
            screenWidth: geo.size.width
          )
          if let item = viewStore.fourthController.selectedItem {
            Text("Selected status: \(item.displayedName)")
          }
        }
      }
    }
    .padding(.horizontal, 20)
  }
}

struct ControllerConsoleView_Previews: PreviewProvider {
  static let items = ["Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum", "Lorem ipsum"].map(SelectableModel.init)
  static let mixedItems = ["Lorem ips", "Lorem ipsum23", "Lorem", "Lorem32", "Lorem4555", "Loremqipsum4535", "Lorem 23412", "ipsum", "Lorem3434ipsum"].map(SelectableModel.init)
  static var previews: some View {
    ControllerConsoleView(
      store: Store(
        initialState: ControllerConsole.State(
          firstController: .init(selectedItems: [], items: items, type: .selectable),
          secondController: .init(selectedItems: [], items: mixedItems, type: .selectable),
          thirdController: .init(selectedItems: [], items: items, type: .segmentable(.two)),
          fourthController: .init(selectedItems: [], items: items, type: .segmentable(.three))
        ),
        reducer: ControllerConsole()
      )
    )
  }
}
