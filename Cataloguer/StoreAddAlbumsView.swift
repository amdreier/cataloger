//
//  StoreAddAlbumView.swift
//  Cataloguer
//
//  Created by Alex Dreier on 8/16/23.
//

import SwiftUI
import Foundation

struct StoreAddAlbumsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var model: CataloguerModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.orange, .teal], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                VStack {
                    ForEach(model.getNewAlbumList(), id: \.self) { album in
                        Button {

                        } label: {
                            Text(album.title)
                        }
                    }
                    Button {
                        
                    } label: {
                        Text("+ Add Album")
                    }
                    Spacer()
                }
            }
            .navigationBarItems(trailing: Button(action: {
                model.endTrip()
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                    Text("Leave Store").foregroundColor(.white).bold(true)
                }
            })
        }
        .environmentObject(model)
        .navigationBarBackButtonHidden(true)
    }
}

struct StoreAddAlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CataloguerModel())
    }
}
