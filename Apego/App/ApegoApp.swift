//
//  ApegoApp.swift
//  Apego
//
//  Created by Daniel Nobre on 17/06/24.
//

import SwiftUI
import SwiftData

@main
struct ApegoApp: App {
    
    var body: some Scene{
        WindowGroup {
            TabBar()
        }
    }
//    var sharedModelContainer: ModelContainer = {
////        let schema = Schema([
////            Item.self,
////        ])
////        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
////
////        do {
////            return try ModelContainer(for: schema, configurations: [modelConfiguration])
////        } catch {
////            fatalError("Could not create ModelContainer: \(error)")
////        }
////    }()
////
////    var body: some Scene {
////        WindowGroup {
////            TabBar()
////        }
////        .modelContainer(sharedModelContainer)
////    }
}
