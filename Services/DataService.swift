//
//  DataService.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import Foundation

class DataService {
    static func loadKurals() -> [Kural] {
        guard let url = Bundle.main.url(forResource: "Kurals", withExtension: "json") else {
            print("Kurals.json not found")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let kurals = try JSONDecoder().decode([Kural].self, from: data)
            return kurals
        } catch {
            print("Error loading Kurals: \(error)")
            return []
        }
    }
}
