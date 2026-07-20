//
//  HomeView.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: KuralViewModel

    @State private var selectedRandomKural: Kural?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection

                if viewModel.isLoading {
                    loadingSection
                } else if let errorMessage = viewModel.errorMessage {
                    errorSection(message: errorMessage)
                } else {
                    statisticsSection
                    dailyKuralSection
                    actionSection
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Thirukkural Wisdom")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedRandomKural) { kural in
            KuralDetailView(kural: kural)
        }
    }

    private var headerSection: some View {
        VStack(spacing: 14) {
            Image(systemName: "book.closed.fill")
                .font(.system(size: 52))
                .foregroundStyle(.tint)
                .accessibilityHidden(true)

            Text("Thirukkural Wisdom")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Interactive Learning Mobile App")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(
                "Explore timeless wisdom through Tamil couplets, English meanings, images and audio."
            )
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
    }

    private var loadingSection: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text("Loading Kurals…")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }

    private func errorSection(message: String) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Label(
                "Unable to load the Kural data",
                systemImage: "exclamationmark.triangle.fill"
            )
            .font(.headline)
            .foregroundStyle(.red)

            Text(message)
                .font(.callout)
                .foregroundStyle(.secondary)

            Button {
                viewModel.loadKurals()
            } label: {
                Label("Try Again", systemImage: "arrow.clockwise")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }

    private var statisticsSection: some View {
        HStack(spacing: 12) {
            statisticCard(
                value: "\(viewModel.chapters.count)",
                label: "Chapters",
                icon: "books.vertical"
            )

            statisticCard(
                value: "\(viewModel.kurals.count)",
                label: "Kurals",
                icon: "text.book.closed"
            )
        }
    }

    private func statisticCard(
        value: String,
        label: String,
        icon: String
    ) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.tint)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }

    @ViewBuilder
    private var dailyKuralSection: some View {
        if let kural = viewModel.dailyKural {
            VStack(alignment: .leading, spacing: 14) {
                Label("Kural of the Day", systemImage: "sun.max.fill")
                    .font(.headline)

                Text(kural.tamilText)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(kural.englishMeaning)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)

                NavigationLink {
                    KuralDetailView(kural: kural)
                } label: {
                    Label("Read Kural \(kural.id)", systemImage: "arrow.right")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(.secondarySystemGroupedBackground))
            )
        }
    }

    private var actionSection: some View {
        VStack(spacing: 12) {
            NavigationLink {
                ChapterListView()
            } label: {
                actionRow(
                    title: "Browse Chapters",
                    subtitle: "View Kurals organized by chapter",
                    icon: "books.vertical.fill"
                )
            }

            NavigationLink {
                SearchView()
            } label: {
                actionRow(
                    title: "Search Kurals",
                    subtitle: "Search by number, chapter or keyword",
                    icon: "magnifyingglass"
                )
            }

            Button {
                selectedRandomKural = viewModel.randomKural
            } label: {
                actionRow(
                    title: "Random Kural",
                    subtitle: "Discover a Kural at random",
                    icon: "shuffle"
                )
            }
            .buttonStyle(.plain)
        }
    }

    private func actionRow(
        title: String,
        subtitle: String,
        icon: String
    ) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 42, height: 42)
                .background(Color.accentColor.opacity(0.15))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}
