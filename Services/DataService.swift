//
//  DataService.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import Foundation

enum DataServiceError: LocalizedError {
    case fileNotFound
    case emptyFile
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return """
            Kurals.json was not found in the application bundle.
            Check Target Membership and Copy Bundle Resources.
            """

        case .emptyFile:
            return "Kurals.json was found, but it contains no data."

        case .decodingFailed(let error):
            return "Kurals.json could not be decoded: \(error.localizedDescription)"
        }
    }
}

struct DataService {
    static func loadKurals() throws -> [Kural] {
        guard let url = Bundle.main.url(
            forResource: "Kurals",
            withExtension: "json"
        ) else {
            throw DataServiceError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: url)

            guard !data.isEmpty else {
                throw DataServiceError.emptyFile
            }

            let decoder = JSONDecoder()
            return try decoder.decode([Kural].self, from: data)

        } catch let error as DataServiceError {
            throw error
        } catch {
            throw DataServiceError.decodingFailed(error)
        }
    }
}
