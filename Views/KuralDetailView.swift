//
//  KuralDetailView.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import SwiftUI
import UIKit

struct KuralDetailView: View {
    let kural: Kural

    @EnvironmentObject private var favoritesStore: FavoritesStore
    @StateObject private var audioService = AudioService()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                imageSection
                headingSection
                tamilSection
                meaningSection
                audioSection
                favoriteSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Kural \(kural.id)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favoritesStore.toggleFavorite(kural)
                } label: {
                    Image(
                        systemName: favoritesStore.isFavorite(kural)
                            ? "heart.fill"
                            : "heart"
                    )
                }
                .accessibilityLabel(
                    favoritesStore.isFavorite(kural)
                        ? "Remove from Favorites"
                        : "Add to Favorites"
                )
            }
        }
        .onDisappear {
            audioService.stop()
        }
    }

    private var imageSection: some View {
        Group {
            if let imageName = kural.imageName,
               UIImage(named: imageName) != nil {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    LinearGradient(
                        colors: [
                            Color.accentColor.opacity(0.35),
                            Color.accentColor.opacity(0.08)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )

                    VStack(spacing: 12) {
                        Image(systemName: "book.pages.fill")
                            .font(.system(size: 52))

                        Text("Thirukkural Wisdom")
                            .font(.headline)
                    }
                    .foregroundStyle(.primary)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 240)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .accessibilityHidden(true)
    }

    private var headingSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Kural \(kural.id)")
                .font(.largeTitle)
                .fontWeight(.bold)

            Label(
                "Chapter \(kural.chapterNumber): \(kural.chapterName)",
                systemImage: "books.vertical"
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
    }

    private var tamilSection: some View {
        contentCard(title: "Tamil Kural", icon: "text.quote") {
            Text(kural.tamilText)
                .font(.title3)
                .fontWeight(.semibold)
                .lineSpacing(8)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var meaningSection: some View {
        contentCard(title: "English Meaning", icon: "character.book.closed") {
            Text(kural.englishMeaning)
                .font(.body)
                .lineSpacing(5)
        }
    }

    private var audioSection: some View {
        contentCard(title: "Audio Recitation", icon: "speaker.wave.2") {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Button {
                        if audioService.isPlaying {
                            audioService.stop()
                        } else {
                            audioService.play(named: kural.audioName)
                        }
                    } label: {
                        Label(
                            audioService.isPlaying
                                ? "Stop Audio"
                                : "Play Audio",
                            systemImage: audioService.isPlaying
                                ? "stop.fill"
                                : "play.fill"
                        )
                    }
                    .buttonStyle(.borderedProminent)

                    if audioService.isPlaying {
                        ProgressView()
                    }
                }

                if let errorMessage = audioService.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
        }
    }

    private var favoriteSection: some View {
        Button {
            favoritesStore.toggleFavorite(kural)
        } label: {
            Label(
                favoritesStore.isFavorite(kural)
                    ? "Remove from Favorites"
                    : "Add to Favorites",
                systemImage: favoritesStore.isFavorite(kural)
                    ? "heart.slash"
                    : "heart"
            )
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
    }

    private func contentCard<Content: View>(
        title: String,
        icon: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Label(title, systemImage: icon)
                .font(.headline)

            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}
