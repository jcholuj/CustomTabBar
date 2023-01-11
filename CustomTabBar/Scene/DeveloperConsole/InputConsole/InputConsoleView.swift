import ComposableArchitecture
import SwiftUI

struct InputConsoleView: View {
  let store: StoreOf<InputConsole>

    var body: some View {
      WithViewStore(store, observe: { $0 }) { viewStore in
        VStack {
          InputView(
            type: .surname,
            inputValue: viewStore.surnameInputValueBinding,
            isValid: viewStore.surnameIsValidBinding,
            isFocused: viewStore.surnameIsFocusedBinding,
            isSecured: false
          )
          InputView(
            type: .nip,
            inputValue: viewStore.nipInputValueBinding,
            isValid: viewStore.nipIsValidBinding,
            isFocused: viewStore.nipIsFocusedBinding,
            isSecured: false
          )
          InputView(
            type: .password,
            inputValue: viewStore.passwordInputValueBinding,
            isValid: viewStore.passwordIsValidBinding,
            isFocused: viewStore.passwordIsFocusedBinding,
            isSecured: true
          )
        }
        .padding(.horizontal, 20)
      }
    }
}

struct InputDemoView_Previews: PreviewProvider {
  static var previews: some View {
    InputConsoleView(
      store: Store(
        initialState: InputConsole.State(),
        reducer: InputConsole()
      )
    )
  }
}
