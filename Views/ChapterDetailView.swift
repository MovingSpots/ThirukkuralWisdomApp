//
//  ChapterDetailView.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-17.
//

import SwiftUI

struct ChapterDetailView: View {
    let chapter: Chapter

    var body: some View {
        List {
            ForEach(chapter.kurals) { kural in
                NavigationLink {
                    KuralDetailView(kural: kural)
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Kural \(kural.id)")
                            .font(.headline)
                            .foregroundStyle(.tint)

                        Text(kural.tamilText)
                            .font(.body)
                            .lineLimit(2)

                        Text(kural.englishMeaning)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .navigationTitle(chapter.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChapterDetailView(
            chapter: Chapter(
                number: 1,
                name: "The Praise of God",
                kurals: [
                    Kural(
                        id: 1,
                        chapterNumber: 1,
                        chapterName: "The Praise of God",
                        tamilText: """
                        அகர முதல எழுத்தெல்லாம் ஆதி
                        பகவன் முதற்றே உலகு
                        """,
                        englishMeaning: """
                        As the letter A is the first of all letters,
                        so the Eternal God is first in the world.
                        """,
                        imageName: "kural1",
                        audioName: "kural1"
                    )
                ]
            )
        )
        .environmentObject(FavoritesStore())
    }
}
