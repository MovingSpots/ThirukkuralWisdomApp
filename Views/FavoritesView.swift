//
//  FavoritesView.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var viewModel: KuralViewModel
    @EnvironmentObject private var favoritesStore: FavoritesStore

    private var favoriteKurals: [Kural] {
        favoritesStore.favoriteKurals(from: viewModel.kurals)
    }

    var body: some View {
        Group {
            if favoriteKurals.isEmpty {
                ContentUnavailableView {
                    Label("No Favorites", systemImage: "heart")
                } description: {
                    Text(
                        "Open a Kural and tap the heart button to save it."
                    )
                }
            } else {
                List {
                    ForEach(favoriteKurals) { kural in
                        NavigationLink {
                            KuralDetailView(kural: kural)
                        } label: {
                            VStack(alignment: .leading, spacing: 7) {
                                Text("Kural \(kural.id)")
                                    .font(.headline)

                                Text(kural.chapterName)
                                    .font(.subheadline)
                                    .foregroundStyle(.tint)

                                Text(kural.tamilText)
                                    .lineLimit(2)

                                Text(kural.englishMeaning)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .onDelete(perform: deleteFavorites)
                }
            }
        }
        .navigationTitle("Favorites")
    }

    private func deleteFavorites(at offsets: IndexSet) {
        for index in offsets {
            favoritesStore.removeFavorite(favoriteKurals[index])
        }
    }
}
