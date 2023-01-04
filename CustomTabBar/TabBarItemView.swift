//
//  TabBarItemView.swift
//  CustomTabBar
//
//  Created by Chołuj Jędrzej (BL) on 03/01/2023.
//

import SwiftUI

struct TabBarItemView: View {
    @Binding var selectedTab: TabBarItem
    let item: TabBarItem
    @State private var opacity: CGFloat = 0.0

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.blueBackground)
                    .frame(width: 64)
                    .opacity(opacity)
                Image(item.icon)
                    .foregroundColor(
                        selectedTab == item ? .blueSelected : .notSelectedGray
                    )
            }
            Text(item.title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(
                    selectedTab == item ? .blueSelected : .textGray
                )
        }
        .frame(width: 72, height: 64)
        .onTapGesture {
            selectedTab = item
        }
        .onAppear {
            opacity = selectedTab == item ? 1.0 : 0.0
        }
        .onChange(of: selectedTab, perform: { currentTab in
            opacity = currentTab == item ? 1.0 : 0.0
        })
        .animation(.easeInOut(duration: 0.2), value: opacity)
    }
}

struct TabBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TabBarItemView(selectedTab: .constant(.start), item: .start)
            TabBarItemView(selectedTab: .constant(.start), item: .documents)
            TabBarItemView(selectedTab: .constant(.start), item: .services)
        }
    }
}
