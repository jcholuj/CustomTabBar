//
//  ContentView.swift
//  CustomTabBar
//
//  Created by Chołuj Jędrzej (BL) on 03/01/2023.
//

import Combine
import CombineFeedback
import SwiftUI

struct ContentView: View {
    typealias State = ContentViewModel.State
    typealias Event = ContentViewModel.Event

    let store: Store<State, Event>

    init(store: Store<State, Event>) {
      self.store = store
    }

    var body: some View {
        WithContextView(store: store) { context in
            NavigationView {
                content
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            ForEach(TabBarItem.allCases) { item in
                                TabBarItemView(
                                    selectedTab: context.binding(
                                        for: \.selectedTab,
                                        event: .didSelectItem(item: item)),
                                    item: item
                                )
                            }
                        }
                    }
                    .animation(.linear(duration: 0.3), value: context.selectedTab)
            }

        }
    }
    
    private var content: some View {
        switch store.state.selectedTab {
        case .start:
            return Color.brown.ignoresSafeArea()
        case .documents:
            return Color.red.ignoresSafeArea()
        case .scanner:
            return Color.green.ignoresSafeArea()
        case .services:
            return Color.yellow.ignoresSafeArea()
        case .more:
            return Color.pink.ignoresSafeArea()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: ContentViewModel()
        )
    }
}
