import ComposableArchitecture
import SwiftUI

struct BottomBarView: View {
  let items: [BottomBarItem]
  let store: StoreOf<BottomBar>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      NavigationView {
        content(for: viewStore)
          .toolbar {
            ToolbarItemGroup(placement: .status) {
              ForEach(items) { item in
                BottomBarItemView(
                  item: item,
                  selectedTab: viewStore.binding(
                    get: \.selectedTab,
                    send: .didSelectTab(item: item)
                  )
                )
              }
            }
          }
          .animation(
            .linear(duration: 0.3),
            value: viewStore.selectedTab
          )
      }
    }
  }

  @ViewBuilder
  private func content(for viewStore: ViewStore<BottomBar.State, BottomBar.Action>) -> some View {
    switch viewStore.selectedTab {
    case .buttons:
      buttonConsole
    case .inputs:
      inputConsole
    case .scanner:
      controllerConsole
    case .services:
      Color.yellow.ignoresSafeArea()
    case .more:
      Color.pink.ignoresSafeArea()
    }
  }
  
  private var buttonConsole: some View {
    ButtonConsoleView(
      store: Store(
        initialState: ButtonConsole.State(),
        reducer: ButtonConsole()
      )
    )
  }
  
  private var inputConsole: some View {
    InputConsoleView(
      store: Store(
        initialState: InputConsole.State(),
        reducer: InputConsole()
      )
    )
  }
  
  @ViewBuilder
  private var controllerConsole: some View {
    ControllerConsoleView(
      store: Store(
        initialState: ControllerConsole.State(),
        reducer: ControllerConsole()
      )
    )
  }
}
