//
//  FavoritesStore.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-17.
//

import Foundation
import Combine

@MainActor
final class FavoritesStore: ObservableObject {
    @Published private(set) var favoriteIDs: Set<Int> = []

    private let storageKey = "favoriteKuralIDs"

    init() {
        loadFavorites()
    }

    func isFavorite(_ kural: Kural) -> Bool {
        favoriteIDs.contains(kural.id)
    }

    func toggleFavorite(_ kural: Kural) {
        if favoriteIDs.contains(kural.id) {
            favoriteIDs.remove(kural.id)
        } else {
            favoriteIDs.insert(kural.id)
        }

        saveFavorites()
    }

    func removeFavorite(_ kural: Kural) {
        favoriteIDs.remove(kural.id)
        saveFavorites()
    }

    func favoriteKurals(from allKurals: [Kural]) -> [Kural] {
        allKurals
            .filter { favoriteIDs.contains($0.id) }
            .sorted { $0.id < $1.id }
    }

    private func saveFavorites() {
        UserDefaults.standard.set(
            Array(favoriteIDs),
            forKey: storageKey
        )
    }

    private func loadFavorites() {
        let savedIDs = UserDefaults.standard.array(
            forKey: storageKey
        ) as? [Int] ?? []

        favoriteIDs = Set(savedIDs)
    }
}
