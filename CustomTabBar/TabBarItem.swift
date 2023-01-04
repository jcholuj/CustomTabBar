//
//  TabBarItem.swift
//  CustomTabBar
//
//  Created by Chołuj Jędrzej (BL) on 03/01/2023.
//

import Foundation

enum TabBarItem: String, CaseIterable, Identifiable {
    case start
    case documents
    case scanner
    case services
    case more
}

extension TabBarItem {
    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .start:
            return "Start"
        case .documents:
            return "Dokumenty"
        case .scanner:
            return "Skaner QR"
        case .services:
            return "Usługi"
        case .more:
            return "Więcej"
        }
    }
    
    var icon: String {
        switch self {
        case .start:
            return "start"
        case .documents:
            return "documents"
        case .scanner:
            return "scanner"
        case .services:
            return "services"
        case .more:
            return "more"
        }
    }
}
