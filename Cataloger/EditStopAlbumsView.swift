//
//  StoreAddAlbumView.swift
//  Cataloguer
//
//  Created by Alex Dreier on 8/16/23.
//

import SwiftUI
import Foundation

struct EditStopAlbumsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var model: CatalogerModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.orange, .teal], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        ForEach(model.newAlbums, id: \.self) { album in
                            Text(album.title)
                        }
                        NavigationLink {
                            AddStoreAlbumView()
                        } label: {
                            Text("+ Album").frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }.scrollContentBackground(.hidden)
            }
            .navigationBarItems(trailing: Button(action: {
                
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                    Text("Done").foregroundColor(.white).bold(true)
                }
            })
        }
        .environmentObject(model)
        .navigationBarBackButtonHidden(true)
    }
}

struct EditStopAlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        EditStopAlbumsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
    }
}
