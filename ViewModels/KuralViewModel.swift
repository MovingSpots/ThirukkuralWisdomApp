//
//  KuralViewModel.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import Foundation
import Combine

class KuralViewModel: ObservableObject {
    @Published var kurals: [Kural] = []
    @Published var searchText: String = ""

    init() {
        kurals = DataService.loadKurals()
    }

    var filteredKurals: [Kural] {
        if searchText.isEmpty {
            return kurals
        } else {
            return kurals.filter {
                $0.tamilText.contains(searchText) ||
                $0.englishMeaning.localizedCaseInsensitiveContains(searchText) ||
                $0.chapterName.localizedCaseInsensitiveContains(searchText) ||
                String($0.id).contains(searchText)
            }
        }
    }
}
