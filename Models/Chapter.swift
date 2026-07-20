//
//  Chapter.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import Foundation

struct Chapter: Identifiable, Hashable {
    let number: Int
    let name: String
    let kurals: [Kural]

    var id: Int {
        number
    }
}
