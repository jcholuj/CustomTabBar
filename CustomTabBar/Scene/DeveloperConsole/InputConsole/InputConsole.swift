import ComposableArchitecture

struct InputConsole: ReducerProtocol {
  var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { _, _ in .none }
  }
}

extension InputConsole {
  struct State: Equatable {
    var nipState = TextFieldState()
    var surnameState = TextFieldState()
    var passwordState = TextFieldState()
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
  }
}

// MARK: - Helper models

extension InputConsole {
  struct TextFieldState: Equatable {
    @BindableState var isValid = true
    @BindableState var inputValue = ""
  }
}
