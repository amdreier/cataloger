//
//  AddStoreAlbumView.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/19/23.
//

import SwiftUI
import Foundation

enum FocusedElm {
    case text
    case numbers
}

struct AddStoreAlbumView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var model: CatalogerModel
    @State var isCompilation: Bool = false
    @State var isMix: Bool = false
    @State var isGH: Bool = false
    @State var isCollection: Bool = false
    @State var isLive: Bool = false
    @State var genre: String = ""
    @State var title: String = ""
    @State var label: String = ""
    @State var artists: [String] = []
    @State var value: Double = 0
    @State var cost: Double = 0
    @State var records: [Record] = []
    
    @State var numRecords: Int = 0
    @State var speed: Int = 33
    @State var manualMode: Bool = false
    
    @State var releaseYearStr: String = ""
    
    @FocusState var focusedElm: FocusedElm?
    @FocusState var prev: FocusedElm?

    
    
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
    
    let intFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = false
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.black, .white], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                VStack {
                    List {
                        // TODO: Finish adding tracks (maybe own view) and artists (w/ automatic entry)
                        Section(header: Text("Album:").foregroundColor(.brown)) {
                            VStack {
                                HStack {
                                    Text("Title: ")
                                    TextField(text: $title, prompt: Text("Title")){}
                                        .focused($focusedElm, equals: .text)
                                }.disableAutocorrection(true)
                                .onSubmit {
                                    if !manualMode {
                                        var i = 0
                                        for record in records {
                                            record.title = "\(title), Disk \(i + 1)"
                                            i += 1
                                        }
                                    }
                                }.onChange(of: focusedElm, perform: { _ in
                                    if !manualMode {
                                        var i = 0
                                        for record in records {
                                            record.title = "\(title), Disk \(i + 1)"
                                            i += 1
                                        }
                                    }
                                })
                                HStack {
                                    Text("Records: ")
                                    TextField("Number of Records", value: $numRecords, formatter: intFormatter){}.keyboardType(.decimalPad)
                                }.onSubmit {
                                    if numRecords >= 1 {
                                        for i in 0...(numRecords - 1) {
                                            if i > (records.count - 1) {
                                                records.append(Record(title: "\(title), Disk \(i + 1)", album: album, store: model.selectedStore))
                                            }
                                        }
                                    }
                                }
                                .focused($focusedElm, equals: .numbers)
                                .onChange(of: focusedElm, perform: { _ in
                                    if numRecords >= 1 {
                                        for i in 0...(numRecords - 1) {
                                            if i > (records.count - 1) {
                                                records.append(Record(title: "\(title), Disk \(i + 1)", album: album, store: model.selectedStore))
                                            }
                                        }
                                    }
                                })
                                .disableAutocorrection(true)
                                Toggle(isOn: $manualMode, label: {Text("Manual Entry: ")}).onChange(of: manualMode) {newVal in
                                    if !newVal {
                                        var i = 0
                                        for record in records {
                                            record.isGH = isGH
                                            record.isMix = isMix
                                            record.isLive = isLive
                                            record.isCollection = isCollection
                                            record.isCompilation = isCompilation
                                            record.genre = genre
                                            record.releaseYear = (releaseYearStr == "" ? nil : Int(releaseYearStr))
                                            record.label = label
                                            record.speed = speed
                                            record.title = "\(title), Disk \(i + 1)"
                                            i += 1
                                        }
                                    } else {
                                        if numRecords >= 1 {
                                            cost = 0
                                            for i in 0...(min(numRecords - 1, records.count - 1)) {
                                                cost += records[i].cost
                                            }
                                            
                                            value = 0
                                            for i in 0...(min(numRecords - 1, records.count - 1)) {
                                                value += records[i].value
                                            }
                                        }
                                    }
                                }
                                Group {
                                    if !manualMode {
                                        HStack {
                                            Text("Speed: ")
                                            TextField("Speed", value: $speed, formatter: intFormatter){}.keyboardType(.decimalPad)
                                        }.focused($focusedElm, equals: .numbers)
                                            .onSubmit {
                                                if !manualMode {
                                                    for record in records {
                                                        record.speed = speed
                                                    }
                                                }
                                            }.onChange(of: focusedElm, perform: { _ in
                                                if !manualMode {
                                                    for record in records {
                                                        record.speed = speed
                                                    }
                                                }
                                            })
                                    }
                                    HStack {
                                        Text("Genre: ")
                                        TextField(text: $genre, prompt: Text("Genre")){}
                                            .focused($focusedElm, equals: .text)
                                    }.disableAutocorrection(true)
                                    .onSubmit {
                                        if !manualMode {
                                            for record in records {
                                                record.genre = genre
                                            }
                                        }
                                    }.onChange(of: focusedElm, perform: { _ in
                                        if !manualMode {
                                            for record in records {
                                                record.genre = genre
                                            }
                                        }
                                    })
                                    HStack {
                                        Text("Release Year: ")
                                        TextField(text: $releaseYearStr, prompt: Text("Release Year")){}.keyboardType(.decimalPad)
                                    }.focused($focusedElm, equals: .numbers)
                                    .onSubmit {
                                        if !manualMode {
                                            for record in records {
                                                record.releaseYear = (releaseYearStr == "" ? nil : Int(releaseYearStr))
                                            }
                                        }
                                    }.onChange(of: focusedElm, perform: { _ in
                                        if !manualMode {
                                            for record in records {
                                                record.releaseYear = (releaseYearStr == "" ? nil : Int(releaseYearStr))
                                            }
                                        }
                                    })
                                    HStack {
                                        Text("Label: ")
                                        TextField(text: $label, prompt: Text("Label")){}
                                            .focused($focusedElm, equals: .text)
                                    }.disableAutocorrection(true)
                                    .onSubmit {
                                        if !manualMode {
                                            for record in records {
                                                record.label = label
                                            }
                                        }
                                    }.onChange(of: focusedElm, perform: { _ in
                                        if !manualMode {
                                            for record in records {
                                                record.label = label
                                            }
                                        }
                                    })
                                }
                                HStack {
                                    Text("Cost: ")
                                    TextField("Cost", value: $cost, formatter: currencyFormatter){}.keyboardType(.decimalPad)
                                }.focused($focusedElm, equals: .numbers)
                                HStack {
                                    Text("Value: ")
                                    TextField("Value", value: $value, formatter: currencyFormatter){}.keyboardType(.decimalPad)
                                }.focused($focusedElm, equals: .numbers)
                                Group {
                                    Toggle(isOn: $isCompilation, label: {Text("Compilation: ")}).onChange(of: isCompilation) {newValue in
                                        if !manualMode {
                                            for record in records {
                                                record.isCompilation = newValue
                                            }
                                        }
                                    }
                                    Toggle(isOn: $isMix, label: {Text("Mix: ")}).onChange(of: isMix) {newValue in
                                        if !manualMode {
                                            for record in records {
                                                record.isMix = newValue
                                            }
                                        }
                                    }
                                    Toggle(isOn: $isGH, label: {Text("Greatest Hits: ")}).onChange(of: isGH) {newValue in
                                        if !manualMode {
                                            for record in records {
                                                record.isGH = newValue
                                            }
                                        }
                                    }
                                    Toggle(isOn: $isCollection, label: {Text("Collection: ")}).onChange(of: isCollection) {newValue in
                                        if !manualMode {
                                            for record in records {
                                                record.isCollection = newValue
                                            }
                                        }
                                    }
                                    Toggle(isOn: $isLive, label: {Text("Live: ")}).onChange(of: isLive) {newValue in
                                        if !manualMode {
                                            for record in records {
                                                record.isLive = newValue
                                            }
                                        }
                                    }
                                }
                            }
                            Section(header: Text("Artists:").foregroundColor(.brown)) {
                                VStack {
                                    ForEach(artists, id: \.self) {artist in
                                        Text(artist)
                                    }
                                }
                            }
                        }.headerProminence(.increased)
                        
                        if ((min(numRecords - 1, records.count - 1)) >= 0) {
                            Section(header: Text("Records:").foregroundColor(.brown)) {
                                ForEach(0...(min(numRecords - 1, records.count - 1)), id: \.self) {i in
                                    Section(header: Text("Record \(i + 1):").foregroundColor(.brown)) {
                                        VStack {
                                            if manualMode {
                                                HStack {
                                                    Text("Cost: ")
                                                    TextField("Cost", value: $records[i].cost, formatter: currencyFormatter){}.keyboardType(.decimalPad)
                                                        .focused($focusedElm, equals: .numbers)
                                                }.onSubmit {
                                                    if manualMode {
                                                        cost = 0
                                                        for i in 0...(min(numRecords - 1, records.count - 1)) {
                                                            cost += records[i].cost
                                                        }
                                                    }
                                                }.onChange(of: focusedElm, perform: { _ in
                                                    if manualMode {
                                                        cost = 0
                                                        for i in 0...(min(numRecords - 1, records.count - 1)) {
                                                            cost += records[i].cost
                                                        }
                                                    }
                                                })
                                                HStack {
                                                    Text("Value: ")
                                                    TextField("Value", value: $records[i].value, formatter: currencyFormatter){}.keyboardType(.decimalPad)
                                                        .focused($focusedElm, equals: .numbers)
                                                }.onSubmit {
                                                    if manualMode {
                                                        value = 0
                                                        for i in 0...(min(numRecords - 1, records.count - 1)) {
                                                            value += records[i].value
                                                        }
                                                    }
                                                }.onChange(of: focusedElm, perform: { _ in
                                                    if manualMode {
                                                        value = 0
                                                        for i in 0...(min(numRecords - 1, records.count - 1)) {
                                                            value += records[i].value
                                                        }
                                                    }
                                                })
                                                Group {
                                                    HStack {
                                                        Text("Title: ")
                                                        TextField(text: $records[i].title, prompt: Text("Title")){}
                                                    }
                                                    .focused($focusedElm, equals: .text)
                                                    .disableAutocorrection(true)
                                                    HStack {
                                                        Text("Speed: ")
                                                        TextField("Speed", value: $records[i].speed, formatter: intFormatter){}.keyboardType(.decimalPad)
                                                    }.focused($focusedElm, equals: .numbers)
                                                    HStack {
                                                        Text("Genre: ")
                                                        TextField(text: $records[i].genre, prompt: Text("Genre")){}
                                                            .focused($focusedElm, equals: .text)
                                                    }.disableAutocorrection(true)
                                                    HStack {
                                                        Text("Label: ")
                                                        TextField(text: $records[i].label, prompt: Text("Label")){}
                                                            .focused($focusedElm, equals: .text)
                                                    }.disableAutocorrection(true)
                                                    Toggle(isOn: $records[i].isCompilation, label: {Text("Compilation: ")})
                                                    Toggle(isOn: $records[i].isMix, label: {Text("Mix: ")})
                                                    Toggle(isOn: $records[i].isGH, label: {Text("Greatest Hits: ")})
                                                    Toggle(isOn: $records[i].isCollection, label: {Text("Collection: ")})
                                                    Toggle(isOn: $records[i].isLive, label: {Text("Live: ")})
                                                }
                                            }
                                        }
                                    }
                                }
                            }.headerProminence(.increased)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                .toolbar {
                    if (focusedElm == .numbers) {
                        ToolbarItem(placement: .keyboard) {
                            Button("Done") {
                                prev = focusedElm
                                focusedElm = nil
                            }
                        }
                    }
                }
            }
            
            .navigationBarItems(trailing: Button(action: {
                model.addBoughtAlbumToStop(isCompilation: isCompilation, isMix: isMix, isGH: isGH, isCollection: isCollection, isLive: isLive, genre: genre, releaseYear: (releaseYearStr == "" ? nil : Int(releaseYearStr)), title: title, label: label, artists: artists, value: value, cost: cost, records: records)
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
        AddStoreAlbumView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
    }
}
