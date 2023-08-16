//
//  NewStoreView.swift
//  Cataloguer
//
//  Created by Alex Dreier on 8/16/23.
//

import SwiftUI
import Foundation

struct NewStoreView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var model: CataloguerModel
    
    var body: some View {
        NavigationView {
            Text("test")
        }
    }
    
    
}

struct NewStoreView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CataloguerModel())
    }
}
