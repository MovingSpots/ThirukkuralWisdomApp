//
//  ChapterListView.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import SwiftUI

struct ChapterListView: View {
    @EnvironmentObject private var viewModel: KuralViewModel

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading chapters…")
            } else if let errorMessage = viewModel.errorMessage {
                ContentUnavailableView {
                    Label(
                        "Unable to Load Chapters",
                        systemImage: "exclamationmark.triangle"
                    )
                } description: {
                    Text(errorMessage)
                } actions: {
                    Button("Try Again") {
                        viewModel.loadKurals()
                    }
                }
            } else if viewModel.chapters.isEmpty {
                ContentUnavailableView(
                    "No Chapters Found",
                    systemImage: "books.vertical",
                    description: Text(
                        "No Kural data is currently available."
                    )
                )
            } else {
                chapterList
            }
        }
        .navigationTitle("Chapters")
    }

    private var chapterList: some View {
        List(viewModel.chapters) { chapter in
            NavigationLink {
                ChapterDetailView(chapter: chapter)
            } label: {
                HStack(spacing: 14) {
                    Text("\(chapter.number)")
                        .font(.headline)
                        .frame(width: 42, height: 42)
                        .background(Color.accentColor.opacity(0.15))
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text(chapter.name)
                            .font(.headline)

                        Text("\(chapter.kurals.count) Kurals")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}
