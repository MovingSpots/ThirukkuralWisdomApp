//
//  SearchView.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: KuralViewModel

    var body: some View {
        List(viewModel.filteredKurals) { kural in
            NavigationLink {
                KuralDetailView(kural: kural)
            } label: {
                Text("Kural \(kural.id) - \(kural.chapterName)")
            }
        }
        .searchable(text: $viewModel.searchText)
        .navigationTitle("Search")
    }
}
