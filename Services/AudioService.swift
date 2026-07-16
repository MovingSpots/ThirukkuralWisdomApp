//
//  AudioService.swift
//  ThirukkuralWisdomApp
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-15.
//

import AVFoundation

class AudioService {
    private var player: AVAudioPlayer?

    func playAudio(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Audio file not found")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Audio error: \(error)")
        }
    }

    func stopAudio() {
        player?.stop()
    }
}
