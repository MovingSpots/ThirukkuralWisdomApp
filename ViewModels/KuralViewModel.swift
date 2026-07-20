//
//  KuralViewModel.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import Foundation
import Combine

@MainActor
final class KuralViewModel: ObservableObject {
    @Published private(set) var kurals: [Kural] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published var searchText = ""

    init() {
        loadKurals()
    }

    var chapters: [Chapter] {
        let groupedKurals = Dictionary(
            grouping: kurals,
            by: { $0.chapterNumber }
        )

        return groupedKurals.keys.sorted().compactMap { chapterNumber in
            guard let chapterKurals = groupedKurals[chapterNumber],
                  let firstKural = chapterKurals.first else {
                return nil
            }

            return Chapter(
                number: chapterNumber,
                name: firstKural.chapterName,
                kurals: chapterKurals.sorted { $0.id < $1.id }
            )
        }
    }

    var filteredKurals: [Kural] {
        let trimmedSearch = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedSearch.isEmpty else {
            return kurals
        }

        return kurals.filter { kural in
            String(kural.id).contains(trimmedSearch) ||
            String(kural.chapterNumber).contains(trimmedSearch) ||
            kural.chapterName.localizedCaseInsensitiveContains(trimmedSearch) ||
            kural.tamilText.localizedCaseInsensitiveContains(trimmedSearch) ||
            kural.englishMeaning.localizedCaseInsensitiveContains(trimmedSearch)
        }
    }

    var dailyKural: Kural? {
        guard !kurals.isEmpty else {
            return nil
        }

        let day = Calendar.current.ordinality(
            of: .day,
            in: .year,
            for: Date()
        ) ?? 1

        let index = (day - 1) % kurals.count
        return kurals[index]
    }

    var randomKural: Kural? {
        kurals.randomElement()
    }

    func loadKurals() {
        isLoading = true
        errorMessage = nil

        do {
            kurals = try DataService.loadKurals()
            print("Successfully loaded \(kurals.count) Kurals.")
        } catch {
            kurals = []
            errorMessage = error.localizedDescription
            print("Kural loading error: \(error)")
        }

        isLoading = false
    }
}
