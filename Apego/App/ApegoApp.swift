//
//  ApegoApp.swift
//  Apego
//
//  Created by Daniel Nobre on 17/06/24.
//

import SwiftUI
import SwiftData
import TipKit
import simple_keyframe_animations


@main
struct ApegoApp: App {
    
    @StateObject private var pipeline = EffectsPipeline()
    @State private var isSplashScreenActive = true // Controla a exibição da splash screen
    
    var body: some Scene {
        WindowGroup {
            if isSplashScreenActive {
                SplashScreenView(isActivated: $isSplashScreenActive)
            } else {
                TabBar()
                    .task {
                        try? Tips.configure([
                            .datastoreLocation(.applicationDefault)
                        ])
                    }
                    .preferredColorScheme(.light)
            }
        }
        .modelContainer(for: RoupaModelo.self)
    }
}

