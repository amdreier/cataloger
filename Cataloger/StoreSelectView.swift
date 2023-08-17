//
//  StoreSelectView.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/16/23.
//

import SwiftUI
import Foundation

struct StoreSelectView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var model: CatalogerModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.mint, .teal], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                VStack {
                    ForEach(model.stores, id: \.self) { stop in
                        NavigationLink {
                            StoreAddAlbumsView()
                        } label: {
                            HStack {
                                Text(stop.name).padding().foregroundColor(.white)
                                Spacer()
                                Image(systemName: "arrow.right").padding().foregroundColor(.white)
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
            .navigationBarItems(trailing: Button(action: {
                model.endTrip()
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
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
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
    }
}
