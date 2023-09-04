//
//  AddRecordTrackView.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/22/23.
//

import SwiftUI
import Foundation

struct AddRecordTrackView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var model: CatalogerModel
    
    @State var title: String = ""
    @State var releaseYearStr: String
    @State var artists: [String]
    @State var genre: String
    @State var isLive: Bool
    
    @State var newArtistName = ""
    
    @State var isMix: Bool
    
    var record: Record
    
    @FocusState var focusedElm: FocusedElm?
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.white, .black], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                List {
                    Section(header: Text("Track:").foregroundColor(.brown)) {
                        VStack {
                            HStack {
                                Text("Title: ")
                                TextField(text: $title, prompt: Text("Title")){}
                                    .focused($focusedElm, equals: .text)
                            }.disableAutocorrection(true)
                            HStack {
                                Text("Release Year: ")
                                TextField(text: $releaseYearStr, prompt: Text("Release Year")){}.keyboardType(.decimalPad)
                            }.focused($focusedElm, equals: .numbers)
                            HStack {
                                Text("Genre: ")
                                TextField(text: $genre, prompt: Text("Genre")){}
                                    .focused($focusedElm, equals: .text)
                            }.disableAutocorrection(true)
                            Toggle(isOn: $isLive, label: {Text("Live: ")})
                            Section(header: Text("Artists:").foregroundColor(.brown)) {
                                if artists.count >= 1 {
                                    VStack {
                                        ForEach(artists, id: \.self) {artist in
                                            Text(artist).frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                }
                                if isMix {
                                    HStack {
                                        Text("Artist: ")
                                        TextField(text: $newArtistName, prompt: Text("Artist Name")){}
                                            .focused($focusedElm, equals: .text)
                                    }.disableAutocorrection(true)
                                        .onSubmit {
                                            if newArtistName != "" && !artists.contains(newArtistName) {
                                                artists.append(newArtistName)
                                                newArtistName = ""
                                            }
                                            
                                            if isMix {
                                                record.artistsDat = Array(Set(artists + record.artists)).sorted() as [NSString]
                                            }
                                        }.onChange(of: focusedElm, perform: { _ in
                                            if newArtistName != "" && !artists.contains(newArtistName) {
                                                artists.append(newArtistName)
                                                newArtistName = ""
                                            }
                                            
                                            if isMix {
                                                record.artistsDat = Array(Set(artists + record.artists)).sorted() as [NSString]
                                            }
                                        })
                                }
                            }
                        }
                    }.headerProminence(.increased)
                }.toolbar {
                    if (focusedElm == .numbers) {
                        ToolbarItem(placement: .keyboard) {
                            Button("Done") {
                                focusedElm = nil
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationBarItems(trailing: Button(action: {
                model.objectWillChange.send()
                if title != "" {
                    record.addToTracksDat(Track(context: viewContext, title: title, artists: artists, releaseYear: (releaseYearStr == "" ? nil : Int(releaseYearStr)), genre: genre, isLive: isLive))
                }
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                    Text("Finish Track").foregroundColor(.white).bold(true)
                }
            })
        }
        .environmentObject(model)
        .navigationBarBackButtonHidden(true)
    }
}

//struct AddRecordTrackView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRecordTrackView(releaseYearStr: "", artists: ["Luis"], genre: "", isLive: false, isMix: true, record: Record(context: <#NSManagedObjectContext#>)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
//    }
//}
