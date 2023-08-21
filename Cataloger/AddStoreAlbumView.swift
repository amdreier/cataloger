//
//  AddStoreAlbumView.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/19/23.
//

import SwiftUI
import Foundation

enum FocusedElm {
    case NA
    case recordsFocused
    case costFocused
    case recordsCost
}

struct AddStoreAlbumView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var model: CatalogerModel
    @State var isCompilation: Bool = false
    @State var isMix: Bool = false
    @State var isGH: Bool = false
    @State var isCollection: Bool = false
    @State var isLive: Bool = false
    @State var genre: String = "N/A"
    @State var releaseYear: Int = -1
    @State var title: String = ""
    @State var label: String = "N/A"
    @State var artists: [String] = ["N/A"]
    @State var value: Double = 0
    @State var cost: Double = 0
    @State var records: [Record] = []
    
    @State var numRecords: Int = 0
    
    @FocusState var focusedElm: FocusedElm?

    
    
    var album = Album()
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ZStack {
//                LinearGradient(colors: [.yellow, .orange], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                List {
                    // TODO: Finish required fields + appropriate record/album field generation
                    Section(header: Text("Album:")) {
                        VStack {
                            HStack {
                                Text("Title: ")
                                TextField(text: $title, prompt: Text("Title")){}
                                .focused($focusedElm, equals: .NA)
                            }
                            .disableAutocorrection(true)
                            HStack {
                                Text("Records: ")
                                TextField("Number of Records", value: $numRecords, formatter: NumberFormatter()){}.keyboardType(.decimalPad)
                            }.onSubmit {
                                if numRecords >= 1 {
                                    for i in 0...(numRecords - 1) {
                                        if i > (records.count - 1) {
                                            records.append(Record(album: album, store: model.selectedStore))
                                        }
                                    }
                                }
                            }
                            .focused($focusedElm, equals: .recordsFocused)
                            .onChange(of: focusedElm, perform: { _ in
                                if numRecords >= 1 {
                                    for i in 0...(numRecords - 1) {
                                        if i > (records.count - 1) {
                                            records.append(Record(album: album, store: model.selectedStore))
                                        }
                                    }
                                }
                            })
                            .toolbar {
                                if (focusedElm != .NA) {
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            focusedElm = nil
                                        }
                                    }
                                }
                            }
                            .disableAutocorrection(true)
                            HStack {
                                Text("Cost: ")
                                TextField("Cost", value: $cost, formatter: currencyFormatter){}.keyboardType(.decimalPad)
                            }.focused($focusedElm, equals: FocusedElm.costFocused)
                            Toggle(isOn: $isCompilation, label: {Text("Compilation: ")})
                        }
                    }
                    
                    if ((min(numRecords - 1, records.count - 1)) >= 0) {
                        ForEach(0...(min(numRecords - 1, records.count - 1)), id: \.self) {i in
                            Section(header: Text("Record \(i + 1):")) {
                                VStack {
                                    HStack {
                                        Text("Title: ")
                                        TextField(text: $records[i].title, prompt: Text("Title")){}
                                    }
                                    .focused($focusedElm, equals: .NA)
                                    .disableAutocorrection(true)
                                    HStack {
                                        Text("Cost: ")
                                        TextField("Cost", value: $records[i].cost, formatter: currencyFormatter){}.keyboardType(.decimalPad)
                                            .focused($focusedElm, equals: .recordsCost)
                                    }.onSubmit {
                                        cost = 0
                                        for i in 0...(min(numRecords - 1, records.count - 1)) {
                                            cost += records[i].cost
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            .navigationBarItems(trailing: Button(action: {
                model.addBoughtAlbumToStop(isCompilation: isCompilation, isMix: isMix, isGH: isGH, isCollection: isCollection, isLive: isLive, genre: genre, releaseYear: releaseYear, title: title, label: label, artists: artists, value: value, cost: cost, records: records)
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                    Text("Finish").foregroundColor(.black).bold(true)
                }
            })
        }
        .environmentObject(model)
        .navigationBarBackButtonHidden(true)
    }
}

//struct RecordDetailsForm: View {
//    var record: Int
//
//    init(record: Int) {
//        self.record = record
//    }
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Title: ")
//                TextField(text: $title, prompt: Text("Title")){}
//            }
//            .disableAutocorrection(true)
//            HStack {
//                Text("Records: ")
//                TextField("Number of Records", value: $numRecords, formatter: NumberFormatter()){}
//            }
//            .disableAutocorrection(true)
//            Toggle(isOn: $isCompilation, label: {Text("Compilation: ")})
//        }
//    }
//}

struct AddStoreAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
    }
}
