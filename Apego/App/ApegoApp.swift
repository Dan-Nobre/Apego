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
    @State private var isActivated = false

    var body: some Scene {
        WindowGroup {
            if isActivated {
                TabBar()
                    .preferredColorScheme(.light)
            } else {
                SplashScreenView(isActivated: $isActivated)
            }
        }
    }
}
