import ComposableArchitecture
import SwiftUI

struct InputConsoleView: View {
  let store: StoreOf<InputConsole>

    var body: some View {
      WithViewStore(store) { viewStore in
        VStack {
          InputView(
            type: .text,
            title: "Nazwisko",
            placeholder: "Wpisz swoje nazwisko",
            inputValue: viewStore.binding(\.surnameState.$inputValue),
            isValid: viewStore.binding(\.surnameState.$isValid)
          )
          InputView(
            type: .search,
            title: "Urząd Skarbowy",
            placeholder: "Wyszukaj Urząd",
            inputValue: viewStore.binding(\.nipState.$inputValue),
            isValid: viewStore.binding(\.nipState.$isValid),
            tooltipAction: {}
          )
          InputView(
            type: .secured,
            title: "Hasło",
            placeholder: "Wpisz hasło",
            inputValue: viewStore.binding(\.passwordState.$inputValue),
            isValid: viewStore.binding(\.passwordState.$isValid)
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
