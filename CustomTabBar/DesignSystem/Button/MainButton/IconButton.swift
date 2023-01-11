import ComposableArchitecture
import SwiftUI

struct Icon: ReducerProtocol {
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    .none
  }
}

extension Icon {
  struct State: Equatable {
    let icon: String
  }
  
  enum Action: Equatable {
    case buttonTapped
  }
}

struct IconButton: View {
  //let store: StoreOf<Icon>
  let icon: String
  let action: () -> ()
  
  var body: some View {
//    WithViewStore(store, observe: { $0 }) { viewStore in
//      Button(action: {
//        viewStore.send(.buttonTapped)
//      }) {
//        Image(viewStore.state.icon)
//          .resizable()
//          .aspectRatio(contentMode: .fit)
//          .frame(width: 24, height: 24)
//      }
//      .frame(width: 56, height: 56)
//    }
    Button(action: action) {
      Image(icon)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 24, height: 24)
    }
    .frame(width: 56, height: 56)
  }
}
