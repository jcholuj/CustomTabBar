//
//  ContentViewModel.swift
//  CustomTabBar
//
//  Created by Chołuj Jędrzej (BL) on 04/01/2023.
//

import CombineFeedback

final class ContentViewModel: Store<ContentViewModel.State, ContentViewModel.Event> {
    init() {
        super.init(
            initial: State(),
            feedbacks: [],
            reducer: ContentViewModel.reducer(),
            dependency: ()
        )
    }
}

extension ContentViewModel {
    struct State: Equatable {
        var selectedTab: TabBarItem = .start
    }

    enum Event {
        case didSelectItem(item: TabBarItem)
    }

    static func reducer() -> Reducer<State, Event> {
        .init { state, event in
            switch event {
            case let .didSelectItem(item):
                state.selectedTab = item
            }
        }
    }
}
