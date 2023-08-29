//
//  CatalogerApp.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/8/23.
//

import SwiftUI

@main
struct CatalogerApp: App {
    let persistenceController = PersistenceController.shared
    
    @FetchRequest(sortDescriptors: [])
    private var modelSet: FetchedResults<CatalogerModel>

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(modelSet.first ?? CatalogerModel(context: persistenceController.container.viewContext))
        }
    }
}
