//
//  KuralDetailView.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import SwiftUI

struct KuralDetailView: View {
    let kural: Kural
    private let audioService = AudioService()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(kural.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(12)

                Text("Kural \(kural.id)")
                    .font(.title)
                    .bold()

                Text(kural.tamilText)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()

                Text(kural.englishMeaning)
                    .font(.body)
                    .padding()

                Button("Play Audio") {
                    audioService.playAudio(named: kural.audioName)
                }
                .buttonStyle(.borderedProminent)

                Button("Stop Audio") {
                    audioService.stopAudio()
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .navigationTitle(kural.chapterName)
    }
}
