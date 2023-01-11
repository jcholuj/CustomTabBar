import ComposableArchitecture
import SwiftUI

struct DashboardView: View {
  var body: some View {
    BottomBarView(
      items: [.buttons, .inputs, .scanner],
      store: Store(
        initialState: BottomBar.State(),
        reducer: BottomBar()
      )
    )
  }
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView()
  }
}

