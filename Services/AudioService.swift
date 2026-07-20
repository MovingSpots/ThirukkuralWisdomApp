//
//  AudioService.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import AVFoundation
import Foundation
import Combine

@MainActor
final class AudioService: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published private(set) var isPlaying = false
    @Published private(set) var errorMessage: String?

    private var audioPlayer: AVAudioPlayer?

    func play(named fileName: String?) {
        guard let fileName, !fileName.isEmpty else {
            errorMessage = "Audio is not available for this Kural."
            return
        }

        guard let url = Bundle.main.url(
            forResource: fileName,
            withExtension: "mp3"
        ) else {
            errorMessage = """
            \(fileName).mp3 was not found.
            Check Target Membership and Copy Bundle Resources.
            """
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()

            isPlaying = true
            errorMessage = nil
        } catch {
            isPlaying = false
            errorMessage = "Unable to play audio: \(error.localizedDescription)"
        }
    }

    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
    }

    nonisolated func audioPlayerDidFinishPlaying(
        _ player: AVAudioPlayer,
        successfully flag: Bool
    ) {
        Task { @MainActor in
            isPlaying = false
        }
    }
}
