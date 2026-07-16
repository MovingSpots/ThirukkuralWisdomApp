//
//  HomeView.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = KuralViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Thirukkural Wisdom")
                    .font(.largeTitle)
                    .bold()

                Text("Interactive Learning Mobile App")
                    .font(.headline)

                NavigationLink("View Kurals") {
                    ChapterListView(viewModel: viewModel)
                }
                .buttonStyle(.borderedProminent)

                NavigationLink("Search Kurals") {
                    SearchView(viewModel: viewModel)
                }
                .buttonStyle(.bordered)

                NavigationLink("Favorites") {
                    FavoritesView()
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }
}
