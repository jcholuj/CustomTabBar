import ComposableArchitecture
import SwiftUI

struct ControllerConsoleView: View {
  let store: StoreOf<ControllerConsole>
  
  var body: some View {
    GeometryReader { geo in
      WithViewStore(store) { viewStore in
        VStack(spacing: 20) {
          ControllerView(items: viewStore.state.firstController.items, type: .selectable, screenWidth: geo.size.width, selectedItems: viewStore.binding(\.firstController.$selectedItems))
          Text("Selected items count: \(viewStore.firstController.selectedItems.count)")
          ControllerView(
            items: viewStore.state.secondController.items,
            type: viewStore.state.secondController.type,
            screenWidth: geo.size.width,
            selectedItems: viewStore.binding(\.secondController.$selectedItems)
          )
          Text("Selected items count: \(viewStore.secondController.selectedItems.count)")
          ControllerView(
            items: viewStore.state.thirdController.items,
            type: viewStore.state.thirdController.type,
            screenWidth: geo.size.width,
            selectedItems: viewStore.binding(\.thirdController.$selectedItems)
          )
          if let item = viewStore.state.thirdController.selectedItems.first {
            Text("Selected status: \(item.displayedName)")
          }
          ControllerView(
            items: viewStore.state.fourthController.items,
            type: viewStore.state.fourthController.type,
            screenWidth: geo.size.width,
            selectedItems: viewStore.binding(\.fourthController.$selectedItems)
          )
          if let item = viewStore.state.fourthController.selectedItems.first {
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
          thirdController: .init(selectedItems: [], items: mixedItems, type: .segmentable(.two)),
          fourthController: .init(selectedItems: [], items: mixedItems, type: .segmentable(.three))
        ),
        reducer: ControllerConsole()
      )
    )
  }
}
