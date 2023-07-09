//
//  CataloguerApp.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/8/23.
//

import SwiftUI

@main
struct CataloguerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
