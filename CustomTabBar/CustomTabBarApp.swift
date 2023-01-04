//
//  CustomTabBarApp.swift
//  CustomTabBar
//
//  Created by Chołuj Jędrzej (BL) on 03/01/2023.
//

import SwiftUI

@main
struct CustomTabBarApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: ContentViewModel())
        }
    }
}
