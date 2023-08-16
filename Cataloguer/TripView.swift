//
//  TripView.swift
//  Cataloguer
//
//  Created by Alex Dreier on 8/15/23.
//

import SwiftUI
import Foundation

struct TripView: View {
    
    //@Environment(\.managedObjectContext) private var viewContext

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
    @EnvironmentObject var model: CataloguerModel
    var testStore = Store()
    init() {
        testStore.name = "store1"
        testStore.location = "location1"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.indigo, .teal], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                VStack {
                    if (model.currentTrip != nil) {
                        ForEach(model.currentTrip!.stores, id: \.self) { stop in
                            NavigationLink {
                                Text(stop.location)
                            } label: {
                                Text(stop.name)
                            }
                        }
                    }
                    //                    .onDelete(perform: deleteItems)
                    
                    //                .toolbar {
                    //                    ToolbarItem(placement: .navigationBarTrailing) {
                    //                        EditButton()
                    //                    }
                    //                    ToolbarItem {
                    //                        Button(action: addItem) {
                    //                            Label("Add Item", systemImage: "plus")
                    //                        }
                    //                    }
                    //                }
                    
                    
                    Button {
                        model.currentTrip?.addStore(store: testStore)
                    } label: {
                        Text("Add Stop").foregroundColor(.white)
                    }
                    Spacer()
                }
            }
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            model.endTrip()
            self.mode.wrappedValue.dismiss()
        }){
            HStack{
                //                Image(systemName: "arrow.left")
                Text("End Trip").foregroundColor(.white).bold(true)
            }
        })
    }

    
    struct TripView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CataloguerModel())
        }
    }
}
