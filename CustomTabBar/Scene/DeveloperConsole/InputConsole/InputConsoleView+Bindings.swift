import ComposableArchitecture
import SwiftUI

extension ViewStore where ViewState == InputConsole.State, ViewAction == InputConsole.Action {
  
  // MARK: - Surname bindings
  
  var surnameInputValueBinding: Binding<String> {
    binding(
      get: \.surnameState.inputValue,
      send: InputConsole.Action.surnameHasChanged
    )
  }
  
  var surnameIsValidBinding: Binding<Bool> {
    binding(
      get: \.surnameState.isValid,
      send: InputConsole.Action.none
    )
  }
  
  var surnameIsFocusedBinding: Binding<Bool> {
    binding(
      get: \.surnameState.isFocused,
      send: InputConsole.Action.surnameFocusHasChanged
    )
  }
  
  // MARK: - Nip bindings
  
  var nipInputValueBinding: Binding<String> {
    binding(
      get: \.nipState.inputValue,
      send: InputConsole.Action.nipHasChanged
    )
  }
  
  var nipIsValidBinding: Binding<Bool> {
    binding(
      get: \.nipState.isValid,
      send: InputConsole.Action.none
    )
  }
  
  var nipIsFocusedBinding: Binding<Bool> {
    binding(
      get: \.nipState.isFocused,
      send: InputConsole.Action.nipFocusHasChanged
    )
  }
  
  // MARK: - Password bindings
  
  var passwordInputValueBinding: Binding<String> {
    binding(
      get: \.passwordState.inputValue,
      send: InputConsole.Action.passwordHasChanged
    )
  }
  
  var passwordIsValidBinding: Binding<Bool> {
    binding(
      get: \.passwordState.isValid,
      send: InputConsole.Action.none
    )
  }
  
  var passwordIsFocusedBinding: Binding<Bool> {
    binding(
      get: \.passwordState.isFocused,
      send: InputConsole.Action.passwordFocusHasChanged
    )
  }
}
