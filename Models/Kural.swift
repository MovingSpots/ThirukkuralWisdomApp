//
//  Kural.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import Foundation

struct Kural: Identifiable, Codable, Hashable {
    let id: Int
    let chapterNumber: Int
    let chapterName: String
    let tamilText: String
    let englishMeaning: String
    let imageName: String?
    let audioName: String?

    var displayNumber: String {
        "Kural \(id)"
    }
}
