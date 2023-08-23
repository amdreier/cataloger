//
//  StoreSelectView.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/16/23.
//

import SwiftUI
import Foundation

struct StopCreateView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var model: CatalogerModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.mint, .teal], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        if model.selectedStore == nil {
                            ForEach(model.stores, id: \.self) { store in
                                Button {
                                    model.selectStore(store: store)
                                } label: {
                                    HStack {
                                        Text(store.name).padding(.leading).foregroundColor(.white).bold(true)
                                        Text(store.location).italic(true).foregroundColor(.white)
                                        Spacer().padding()
                                        Text("+").padding(.trailing).foregroundColor(.white)
                                    }.border(.red, width: 2).background(.blue).padding([.top], 2).padding([.leading, .trailing], 10)
                                }
                            }
                            
                            NavigationLink {
                                NewStoreView()
                            } label: {
                                Text("+ New Store")
                            }
                            
                        } else {
                            Button {
                                model.deselectStore()
                            } label: {
                                HStack {
                                    Text(model.selectedStore!.name).padding(.leading).foregroundColor(.white).bold(true)
                                    Text(model.selectedStore!.location).italic(true).foregroundColor(.white)
                                    Spacer().padding()
                                    Text("-").padding(.trailing).foregroundColor(.white).bold(true)
                                }.border(.red, width: 2).background(.blue).padding([.top], 2).padding([.leading, .trailing], 10)
                            }
                            NavigationLink {
                                EditStopAlbumsView()
                            } label: {
                                Text("Edit Albums").foregroundColor(.white).bold(true)
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                model.addStop()
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
    
struct StopCreateView_Previews: PreviewProvider {
    static var previews: some View {
        StopCreateView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
    }
}
