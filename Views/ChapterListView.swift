//
//  ChapterListView.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import SwiftUI

struct ChapterListView: View {
    @ObservedObject var viewModel: KuralViewModel

    var body: some View {
        List(viewModel.kurals) { kural in
            NavigationLink {
                KuralDetailView(kural: kural)
            } label: {
                VStack(alignment: .leading) {
                    Text("Kural \(kural.id)")
                        .font(.headline)

                    Text(kural.chapterName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Kurals")
    }
}
