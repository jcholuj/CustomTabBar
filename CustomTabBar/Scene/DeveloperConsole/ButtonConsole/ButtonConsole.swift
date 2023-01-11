import ComposableArchitecture

struct ButtonConsole: ReducerProtocol {
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .primaryButtonTapped:
      state.primaryButtonTapCounter += 1
      return .none
    case .secondaryButtonTapped:
      state.secondaryButtonTapCounter += 1
      return .none
    case .tertiaryButtonTapped:
      state.tertiaryButtonTapCounter += 1
      return .none
    }
  }
  
}

extension ButtonConsole {
  struct State: Equatable {
    var primaryButtonTapCounter = 0
    var secondaryButtonTapCounter = 0
    var tertiaryButtonTapCounter = 0
  }
  enum Action: Equatable {
    case primaryButtonTapped
    case secondaryButtonTapped
    case tertiaryButtonTapped
  }
}
