//
//  CatalogerApp.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/8/23.
//

import SwiftUI


// TODO: figure out ContentView mananagedObjectContext for CatalogerModel
@main
struct CatalogerApp: App {
    let persistenceController = PersistenceController.shared
    
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.userDat!.usernameDat)])
//    private var modelSet: FetchedResults<CatalogerModel>

    var body: some Scene {
        WindowGroup {
            //ContentView()
            CoreDataLoader()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)//.environmentObject(modelSet.first ?? CatalogerModel(context: persistenceController.container.viewContext))
        }
    }
}

