//
//  ThirukkuralWisdomAppApp.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import SwiftUI

@main
struct ThirukkuralWisdomApp: App {
    @StateObject private var viewModel = KuralViewModel()
    @StateObject private var favoritesStore = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(viewModel)
                .environmentObject(favoritesStore)
        }
    }
}
