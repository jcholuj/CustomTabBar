import SwiftUI

struct BottomBarItemView: View {
  let item: BottomBarItem
  
  @Binding var selectedTab: BottomBarItem
  
  @State private var opacity: CGFloat = Constants.zeroOpacity
  
  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .fill(Color.blueBackground)
          .frame(width: Constants.roundedBackgroundWidth)
          .opacity(opacity)
        Image(item.icon)
          .foregroundColor(
            selectedTab == item ? .blueSelected : .notSelectedGray
          )
      }
      Text(item.title)
        .font(Constants.titleFont)
        .foregroundColor(
          selectedTab == item ? .blueSelected : .textGray
        )
    }
    .frame(width: Constants.itemWidth, height: Constants.itemHeight)
    .onTapGesture {
      selectedTab = item
    }
    .onAppear {
      opacity = selectedTab == item ? Constants.fullOpacity : Constants.zeroOpacity
    }
    .onChange(of: selectedTab, perform: { currentTab in
      opacity = currentTab == item ? Constants.fullOpacity : Constants.zeroOpacity
    })
    .animation(Constants.animation, value: opacity)
  }
}

private extension BottomBarItemView {
  enum Constants {
    static let zeroOpacity: CGFloat = 0.0
    static let fullOpacity: CGFloat = 1.0
    static let itemHeight: CGFloat = 64
    static let itemWidth: CGFloat = 72
    static let titleFont: Font = .system(size: 12, weight: .semibold)
    static let roundedBackgroundWidth: CGFloat = 64
    static let cornerRadius: CGFloat = 40
    static let animationDuration: Double = 0.2
    static let animation = Animation.easeInOut(duration: animationDuration)
  }
}
