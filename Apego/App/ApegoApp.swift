//
//  ApegoApp.swift
//  Apego
//
//  Created by Daniel Nobre on 17/06/24.
//

import SwiftUI
import SwiftData
import TipKit

@main
struct ApegoApp: App {
    @StateObject private var pipeline = EffectsPipeline()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView() // Mostra a SplashScreen até que a transição para TabBar ocorra
                .task {
                    try? Tips.configure([
                        .datastoreLocation(.applicationDefault)
                    ])
                }
                .preferredColorScheme(.light)
        }
        .modelContainer(for: RoupaModelo.self)
    }
}
