import ComposableArchitecture

final class BottomBar: ReducerProtocol {
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case let .didSelectTab(item):
      state.selectedTab = item
      return .none
    }
  }
}

extension BottomBar {
  struct State: Equatable {
    var selectedTab: BottomBarItem = .buttons
  }
  
  enum Action {
    case didSelectTab(item: BottomBarItem)
  }
}

