//
//  CoreDataLoader.swift
//  Cataloger
//
//  Created by Alex Dreier on 9/4/23.
//

import SwiftUI

struct CoreDataLoader: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.userDat!.usernameDat)])
    private var modelSet: FetchedResults<CatalogerModel>
    
    var body: some View {
        ContentView().environment(\.managedObjectContext, viewContext).environmentObject(modelSet.first ?? CatalogerModel(context: viewContext))
    }
}

struct CoreDataLoader_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataLoader()
    }
}
