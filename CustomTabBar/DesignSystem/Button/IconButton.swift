import SwiftUI

struct IconButton: View {
  let icon: String
  let action: () -> ()
  
  var body: some View {
    Button(action: action) {
      Image(icon)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 24, height: 24)
    }
    .frame(width: 56, height: 56)
  }
}
