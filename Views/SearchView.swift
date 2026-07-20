//
//  SearchView.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var viewModel: KuralViewModel

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading Kurals…")
            } else if let errorMessage = viewModel.errorMessage {
                ContentUnavailableView {
                    Label(
                        "Search Unavailable",
                        systemImage: "exclamationmark.triangle"
                    )
                } description: {
                    Text(errorMessage)
                } actions: {
                    Button("Try Again") {
                        viewModel.loadKurals()
                    }
                }
            } else if viewModel.kurals.isEmpty {
                ContentUnavailableView(
                    "No Kural Data",
                    systemImage: "doc.text.magnifyingglass",
                    description: Text(
                        "Add Kurals.json to the application target."
                    )
                )
            } else if !viewModel.searchText.isEmpty &&
                        viewModel.filteredKurals.isEmpty {
                ContentUnavailableView.search(
                    text: viewModel.searchText
                )
            } else {
                searchResults
            }
        }
        .navigationTitle("Search")
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Number, chapter, Tamil or English"
        )
    }

    private var searchResults: some View {
        List(viewModel.filteredKurals) { kural in
            NavigationLink {
                KuralDetailView(kural: kural)
            } label: {
                VStack(alignment: .leading, spacing: 7) {
                    HStack {
                        Text("Kural \(kural.id)")
                            .font(.headline)

                        Spacer()

                        Text("Chapter \(kural.chapterNumber)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Text(kural.chapterName)
                        .font(.subheadline)
                        .foregroundStyle(.tint)

                    Text(kural.tamilText)
                        .font(.body)
                        .lineLimit(2)

                    Text(kural.englishMeaning)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                .padding(.vertical, 5)
            }
        }
        .overlay(alignment: .bottom) {
            Text("\(viewModel.filteredKurals.count) result(s)")
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(.thinMaterial)
                .clipShape(Capsule())
                .padding()
        }
    }
}
