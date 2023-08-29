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
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var model: CatalogerModel
    
    @State var storeName = ""
    @State var storeLocation = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    HStack {
                        Text("Name: ")
                        TextField(text: $storeName, prompt: Text("Name")){}
                    }
                    .disableAutocorrection(true)
                    HStack {
                        Text("Location: ")
                        TextField(text: $storeLocation, prompt: Text("Location")){}
                    }
                    .disableAutocorrection(true)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                if storeName != "" {
                    model.addStore(store: Store(context: viewContext, name: storeName, location: storeLocation))
                }
                
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                    Text("Create Store").foregroundColor(.blue).bold(true)
                }
            })
        }
        .environmentObject(model)
        .navigationBarBackButtonHidden(true)
    }
}

//struct NewStoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewStoreView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
//    }
//}
