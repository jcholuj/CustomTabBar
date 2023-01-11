import ComposableArchitecture

struct InputConsole: ReducerProtocol {
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .nipFocusHasChanged:
      state.nipState.isFocused.toggle()
      return .none
    case .surnameFocusHasChanged:
      state.surnameState.isFocused.toggle()
      return .none
    case let .surnameHasChanged(value):
      state.surnameState.inputValue = value
      return .none
    case let .nipHasChanged(value):
      state.nipState.inputValue = value
      return .none
    case .passwordFocusHasChanged:
      state.passwordState.isFocused.toggle()
      return .none
    case let .passwordHasChanged(value):
      state.passwordState.inputValue = value
      return .none
    case .none:
      return .none
    }
  }
}

extension InputConsole {
  struct State: Equatable {
    var nipState = TextFieldState()
    var surnameState = TextFieldState()
    var passwordState = TextFieldState()
  }
  
  enum Action: Equatable {
    case nipFocusHasChanged
    case surnameFocusHasChanged
    case surnameHasChanged(String)
    case nipHasChanged(String)
    case passwordFocusHasChanged
    case passwordHasChanged(String)
    case none
  }
}

// MARK: - Helper models

extension InputConsole {
  struct TextFieldState: Equatable {
    var isValid = true
    var isFocused = false
    var inputValue = ""
  }
}
