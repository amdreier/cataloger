//
//  StoreSelectView.swift
//  Cataloguer
//
//  Created by Alex Dreier on 8/16/23.
//

import SwiftUI
import Foundation

struct StoreSelectView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var model: CataloguerModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.mint, .teal], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                VStack {
                    ForEach(model.stores, id: \.self) { stop in
                        NavigationLink {
                            NavigationView {
                                Text(stop.location)
                            }
                        } label: {
                            HStack {
                                Text(stop.name).padding().foregroundColor(.white)
                                Spacer()
                                Text(">").padding().foregroundColor(.white)
                            }.border(.red, width: 2).background(.blue).padding([.top], 2).padding([.leading, .trailing], 10)
                        }
                    }
                    NavigationLink {
                        NewStoreView()
                    } label: {
                        Text("+ Add New Store")
                    }
                    Spacer()
                }
            }
            .navigationBarItems(leading: Button(action : {
                model.endTrip()
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
    //                Image(systemName: "arrow.left")
                    Text("Finish Stop").foregroundColor(.white).bold(true)
                }
            })
            
        }
        .environmentObject(model)
        .navigationBarBackButtonHidden(true)
    }
}
    
struct StoreSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CataloguerModel())
    }
}
