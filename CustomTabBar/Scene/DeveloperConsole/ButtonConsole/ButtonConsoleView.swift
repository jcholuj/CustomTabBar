import ComposableArchitecture
import SwiftUI

struct ButtonConsoleView: View {
  let store: StoreOf<ButtonConsole>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 24) {
        MainButton(
          title: "Primary",
          action: { viewStore.send(.primaryButtonTapped) }
        )
        MainButton(
          title: "Secondary",
          action: { viewStore.send(.secondaryButtonTapped) },
          type: .secondary
        )
        MainButton(
          title: "Tertiary",
          action: { viewStore.send(.tertiaryButtonTapped) },
          type: .tertiary
        )
        MainButton(
          title: "Primary",
          action: { viewStore.send(.primaryButtonTapped) }
        )
        .disabled(true)
        MainButton(
          title: "Secondary",
          action: { viewStore.send(.secondaryButtonTapped) },
          type: .secondary
        )
        .disabled(true)
        MainButton(
          title: "Tertiary",
          action: { viewStore.send(.tertiaryButtonTapped) },
          type: .tertiary
        )
        .disabled(true)
        Text("Primary button tap counter: \(viewStore.primaryButtonTapCounter)")
        Text("Secondary button tap counter: \(viewStore.secondaryButtonTapCounter)")
        Text("Tertiary button tap counter: \(viewStore.tertiaryButtonTapCounter)")
      }
      .padding(.horizontal, 20)
    }
  }
}

struct ButtonConsoleView_Previews: PreviewProvider {
  static var previews: some View {
    ButtonConsoleView(
      store: Store(
        initialState: ButtonConsole.State(),
        reducer: ButtonConsole()
      )
    )
  }
}

