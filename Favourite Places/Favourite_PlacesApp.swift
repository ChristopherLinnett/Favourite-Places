//
//  Favourite_PlacesApp.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI

@main
struct Favourite_PlacesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
