//
//  TripView.swift
//  Cataloger
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
    @EnvironmentObject var model: CatalogerModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.indigo, .teal], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                VStack {
                    if (model.currentTrip != nil) {
                        ForEach(model.currentTrip!.stops, id: \.self) { stop in
                            NavigationLink {
                                ForEach(stop.newAlbums, id: \.self) { album in
                                    Text(album.title)
                                }
                            } label: {
                                HStack {
                                    Text(stop.store.name).padding().foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "arrow.right").foregroundColor(.white).padding()
                                }.border(.red, width: 2).background(.blue).padding([.top], 2).padding([.leading, .trailing], 10)
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
                    
                    
                    NavigationLink(destination: StopCreateView(), label: {
                        Text("+ Stop").foregroundColor(.white)
                    })
                        
                    Spacer()
                }
            }
            .navigationBarItems(trailing: Button(action : {
                model.endTrip()
                self.mode.wrappedValue.dismiss()
            }) {
                HStack{
                    //                Image(systemName: "arrow.left")
                    Text("End Trip").foregroundColor(.white).bold(true)
                }
            })
        }
        .environmentObject(model)
        .navigationBarBackButtonHidden(true)
    }

    
    struct TripView_Previews: PreviewProvider {
        static var previews: some View {
            TripView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
        }
    }
}
