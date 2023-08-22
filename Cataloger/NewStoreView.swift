//
//  NewStoreView.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/16/23.
//

import SwiftUI
import Foundation

struct NewStoreView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var model: CatalogerModel
    
    var body: some View {
        NavigationView {
            Text("test")
        }
    }
    
    
}

struct NewStoreView_Previews: PreviewProvider {
    static var previews: some View {
        NewStoreView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
    }
}
