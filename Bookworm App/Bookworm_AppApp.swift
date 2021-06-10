//
//  Bookworm_AppApp.swift
//  Bookworm App
//
//  Created by Alicia Windsor on 10/06/2021.
//

import SwiftUI

@main
struct Bookworm_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
