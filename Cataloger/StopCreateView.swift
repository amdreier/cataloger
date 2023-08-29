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
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var model: CatalogerModel
    
    @FocusState var focusedElm: FocusedElm?
    
    @State var timeSpent: Int = 0
    @State var timeTraveled: Int = 0
    
    let intFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = false
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.mint, .teal], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                        if model.selectedStore == nil {
                            ScrollView {
                                VStack {
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
                                }
                            }
                        } else {
                            VStack {
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
                                Text("Stop details:")
                                List {
                                    NavigationLink {
                                        EditStopAlbumsView()
                                    } label: {
                                        Text("Albums:")
                                    }
                                    HStack {
                                        Text("Time Spent: ")
                                        TextField("minutes", value: $timeSpent, formatter: intFormatter){}.keyboardType(.decimalPad)
                                    }.focused($focusedElm, equals: .numbers)
                                    HStack {
                                        Text("Travel Time: ")
                                        TextField("minutes", value: $timeTraveled, formatter: intFormatter){}.keyboardType(.decimalPad)
                                    }.focused($focusedElm, equals: .numbers)
                                }
                                .scrollContentBackground(.hidden)
                                .listStyle(PlainListStyle())
                                .padding([.leading, .trailing, .bottom])
                            }
                        }
                        
                        
                    
                
            }
            .navigationBarItems(trailing: Button(action: {
                model.addStop(timeSpent: timeSpent, timeTraveled: timeTraveled)
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
    
//struct StopCreateView_Previews: PreviewProvider {
//    static var previews: some View {
//        StopCreateView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
//    }
//}
