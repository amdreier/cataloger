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

// TODO: show total value
struct AddStoreAlbumView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var model: CatalogerModel
    
    @FocusState var focusedElm: FocusedElm?
    
    @StateObject var formData = FormData()
    
    @State var newArtistName = ""
    
    class FormData: ObservableObject {
        @Published var isCompilation: Bool = false
        @Published var isMix: Bool = false
        @Published var isGH: Bool = false
        @Published var isCollection: Bool = false
        @Published var isLive: Bool = false
        @Published var genre: String = ""
        @Published var title: String = ""
        @Published var label: String = ""
        @Published var artists: [String] = []
        @Published var value: Double = 0
        @Published var cost: Double = 0
        @Published var records: [RecordDetailsView] = []
        
        @Published var numRecords: Int = 0
        @Published var speed: Int = 33
        @Published var manualMode: Bool = false
        
        @Published var releaseYearStr: String = ""
        
        var album = Album()
    }
    
    struct RecordDetailsView: View {
        @ObservedObject var record: Record
        
        @FocusState var focusedElm: FocusedElm?
        
        @ObservedObject var formData: FormData
        
        @State var newTrackTitle: String = ""
        @State var newArtistName: String = ""
        
        let numberFormatter: NumberFormatter
        let currencyFormatter: NumberFormatter
        let intFormatter: NumberFormatter
        
        var body: some View {
            VStack {
                if formData.manualMode {
                    Group {
                        HStack {
                            Text("Cost: ")
                            TextField("Cost", value: $record.cost, formatter: currencyFormatter){}.keyboardType(.decimalPad)
                                .focused($focusedElm, equals: .numbers)
                        }.onSubmit {
                            if formData.manualMode {
                                formData.cost = 0
                                for i in 0...(min(formData.numRecords - 1, formData.records.count - 1)) {
                                    formData.cost += formData.records[i].record.cost
                                }
                            }
                        }.onChange(of: focusedElm, perform: { _ in
                            if formData.manualMode {
                                formData.cost = 0
                                for i in 0...(min(formData.numRecords - 1, formData.records.count - 1)) {
                                    formData.cost += formData.records[i].record.cost
                                }
                            }
                        })
                        HStack {
                            Text("Value: ")
                            TextField("Value", value: $record.value, formatter: currencyFormatter){}.keyboardType(.decimalPad)
                                .focused($focusedElm, equals: .numbers)
                        }.onSubmit {
                            if formData.manualMode {
                                formData.value = 0
                                for i in 0...(min(formData.numRecords - 1, formData.records.count - 1)) {
                                    formData.value += formData.records[i].record.value
                                }
                            }
                        }.onChange(of: focusedElm, perform: { _ in
                            if formData.manualMode {
                                formData.value = 0
                                for i in 0...(min(formData.numRecords - 1, formData.records.count - 1)) {
                                    formData.value += formData.records[i].record.value
                                }
                            }
                        })
                    }
                    Group {
                        HStack {
                            Text("Title: ")
                            TextField(text: $record.title, prompt: Text("Title")){}
                        }
                        .focused($focusedElm, equals: .text)
                        .disableAutocorrection(true)
                        HStack {
                            Text("Speed: ")
                            TextField("Speed", value: $record.speed, formatter: intFormatter){}.keyboardType(.decimalPad)
                        }.focused($focusedElm, equals: .numbers)
                        HStack {
                            Text("Genre: ")
                            TextField(text: $record.genre, prompt: Text("Genre")){}
                                .focused($focusedElm, equals: .text)
                        }.disableAutocorrection(true)
                        Toggle(isOn: $record.isCompilation, label: {Text("Compilation: ")})
                        Toggle(isOn: $record.isMix, label: {Text("Mix: ")})
                        Toggle(isOn: $record.isGH, label: {Text("Greatest Hits: ")})
                        Toggle(isOn: $record.isCollection, label: {Text("Collection: ")})
                        Toggle(isOn: $record.isLive, label: {Text("Live: ")})
                    }
                }
                Toggle(isOn: $record.trackManualMode, label: {Text("Manual Track Entry: ")})
                Section(header: Text("Tracks:").foregroundColor(.brown)) {
                    VStack {
                        ForEach(record.tracks, id: \.self) {track in
                            Text(track.title).frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    if record.trackManualMode {
                        NavigationLink {
                            AddRecordTrackView(releaseYearStr: ((record.isCompilation || record.isGH || record.isMix) ? "" : formData.releaseYearStr), artists: (record.isMix ? [] : record.artists), genre: record.genre, isLive: record.isLive, isMix: record.isMix, record: record)
                        } label: {
                            Text("+ Track")
                        }
                    } else {
                        HStack {
                            Text("Track Title: ")
                            TextField(text: $newTrackTitle, prompt: Text("TrackTitle")){}
                                .focused($focusedElm, equals: .text)
                        }.disableAutocorrection(true)
                            .onSubmit {
                                if newTrackTitle != "" {
                                    record.tracks.append(Track(title: newTrackTitle, artists: record.artists, releaseYear: record.releaseYear, genre: record.genre, isLive: record.isLive, record: record))
                                    newTrackTitle = ""
                                }
                            }.onChange(of: focusedElm, perform: { _ in
                                if newTrackTitle != "" {
                                    record.tracks.append(Track(title: newTrackTitle, artists: record.artists, releaseYear: record.releaseYear, genre: record.genre, isLive: record.isLive, record: record))
                                    newTrackTitle = ""
                                }
                            })
                    }
                }
                if record.isMix {
                    Section(header: Text("Artists:").foregroundColor(.brown)) {
                        if record.artists.count >= 1 {
                            VStack {
                                ForEach(record.artists, id: \.self) {artist in
                                    Text(artist).frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        
                        HStack {
                            Text("Artist: ")
                            TextField(text: $newArtistName, prompt: Text("Artist Name")){}
                                .focused($focusedElm, equals: .text)
                        }.disableAutocorrection(true)
                            .onSubmit {
                                if !formData.manualMode{
                                    if newArtistName != "" && !formData.artists.contains(newArtistName) {
                                        record.artists.append(newArtistName)
                                        newArtistName = ""
                                    }
                                }
                                
                                if formData.isMix {
                                    formData.artists = Array(Set(record.artists + formData.artists)).sorted()
                                }
                            }.onChange(of: focusedElm, perform: { _ in
                                if !formData.manualMode{
                                    if newArtistName != "" && !formData.artists.contains(newArtistName) {
                                        record.artists.append(newArtistName)
                                        newArtistName = ""
                                    }
                                }
                            }).onChange(of: record.artists, perform: { _ in
                                if formData.isMix {
                                    formData.artists = Array(Set(record.artists + formData.artists)).sorted()
                                }
                            })
                    }
                }
            }
        }
    }
    
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
                        Section(header: Text("Album:").foregroundColor(.brown)) {
                            HStack {
                                Text("Title: ")
                                TextField(text: $formData.title, prompt: Text("Title")){}
                                    .focused($focusedElm, equals: .text)
                            }.disableAutocorrection(true)
                            .onSubmit {
                                if !formData.manualMode {
                                    var i = 0
                                    for record in formData.records {
                                        record.record.title = "\(formData.title), Disk \(i + 1)"
                                        i += 1
                                    }
                                }
                            }.onChange(of: focusedElm, perform: { _ in
                                if !formData.manualMode {
                                    var i = 0
                                    for record in formData.records {
                                        record.record.title = "\(formData.title), Disk \(i + 1)"
                                        i += 1
                                    }
                                }
                            })
                            HStack {
                                Text("Records: ")
                                TextField("Number of Records", value: $formData.numRecords, formatter: intFormatter){}.keyboardType(.decimalPad)
                            }.onSubmit {
                                if formData.numRecords >= 1 {
                                    for i in 0...(formData.numRecords - 1) {
                                        if i > (formData.records.count - 1) {
                                            formData.records.append(RecordDetailsView(record: Record(title: "\(formData.title), Disk \(i + 1)"), formData: formData, numberFormatter: numberFormatter, currencyFormatter: currencyFormatter, intFormatter: intFormatter))
                                        }
                                    }
                                }
                                
                                if !formData.manualMode {
                                    let avgCost = formData.numRecords == 0 ? 0 : formData.cost / Double(formData.numRecords)
                                    let avgValue = formData.numRecords == 0 ? 0 : formData.value / Double(formData.numRecords)
                                    for view in formData.records {
                                        view.record.cost = avgCost
                                        view.record.value = avgValue
                                    }
                                }
                            }
                            .focused($focusedElm, equals: .numbers)
                            .onChange(of: focusedElm, perform: { _ in
                                if formData.numRecords >= 1 {
                                    for i in 0...(formData.numRecords - 1) {
                                        if i > (formData.records.count - 1) {
                                            formData.records.append(RecordDetailsView(record: Record(title: "\(formData.title), Disk \(i + 1)"), formData: formData, numberFormatter: numberFormatter, currencyFormatter: currencyFormatter, intFormatter: intFormatter))
                                        }
                                    }
                                }
                                
                                if !formData.manualMode {
                                    let avgCost = formData.numRecords == 0 ? 0 : formData.cost / Double(formData.numRecords)
                                    let avgValue = formData.numRecords == 0 ? 0 : formData.value / Double(formData.numRecords)
                                    for view in formData.records {
                                        view.record.cost = avgCost
                                        view.record.value = avgValue
                                    }
                                }
                            })
                            .disableAutocorrection(true)
                            Toggle(isOn: $formData.manualMode, label: {Text("Manual Entry: ")}).onChange(of: formData.manualMode) {newVal in
//                                    if !newVal {
//                                        var i = 0
//                                        for record in records {
//                                            record.isGH = isGH
//                                            record.isMix = isMix
//                                            record.isLive = isLive
//                                            record.isCollection = isCollection
//                                            record.isCompilation = isCompilation
//                                            record.genre = genre
//                                            record.releaseYear = (releaseYearStr == "" ? nil : Int(releaseYearStr))
//                                            record.label = label
//                                            record.speed = speed
//                                            record.title = "\(title), Disk \(i + 1)"
//                                            i += 1
//                                        }
//                                    } else {
//                                        if numRecords >= 1 {
//                                            cost = 0
//                                            for i in 0...(min(numRecords - 1, records.count - 1)) {
//                                                cost += records[i].cost
//                                            }
//
//                                            value = 0
//                                            for i in 0...(min(numRecords - 1, records.count - 1)) {
//                                                value += records[i].value
//                                            }
//                                        }
//                                    }
                            }
                            Group {
                                if !formData.manualMode {
                                    HStack {
                                        Text("Speed: ")
                                        TextField("Speed", value: $formData.speed, formatter: intFormatter){}.keyboardType(.decimalPad)
                                    }.focused($focusedElm, equals: .numbers)
                                        .onSubmit {
                                            if !formData.manualMode {
                                                for record in formData.records {
                                                    record.record.speed = formData.speed
                                                }
                                            }
                                        }.onChange(of: focusedElm, perform: { _ in
                                            if !formData.manualMode {
                                                for record in formData.records {
                                                    record.record.speed = formData.speed
                                                }
                                            }
                                        })
                                }
                                HStack {
                                    Text("Genre: ")
                                    TextField(text: $formData.genre, prompt: Text("Genre")){}
                                        .focused($focusedElm, equals: .text)
                                }.disableAutocorrection(true)
                                .onSubmit {
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.genre = formData.genre
                                        }
                                    }
                                }.onChange(of: focusedElm, perform: { _ in
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.genre = formData.genre
                                        }
                                    }
                                })
                                HStack {
                                    Text("Release Year: ")
                                    TextField(text: $formData.releaseYearStr, prompt: Text("Release Year")){}.keyboardType(.decimalPad)
                                }.focused($focusedElm, equals: .numbers)
                                .onSubmit {
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.releaseYear = (formData.releaseYearStr == "" ? nil : Int(formData.releaseYearStr))
                                        }
                                    }
                                }.onChange(of: focusedElm, perform: { _ in
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.releaseYear = (formData.releaseYearStr == "" ? nil : Int(formData.releaseYearStr))
                                        }
                                    }
                                })
                                HStack {
                                    Text("Label: ")
                                    TextField(text: $formData.label, prompt: Text("Label")){}
                                        .focused($focusedElm, equals: .text)
                                }.disableAutocorrection(true)
                                .onSubmit {
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.label = formData.label
                                        }
                                    }
                                }.onChange(of: focusedElm, perform: { _ in
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.label = formData.label
                                        }
                                    }
                                })
                            }
                            HStack {
                                Text("Cost: ")
                                TextField("Cost", value: $formData.cost, formatter: currencyFormatter){}.keyboardType(.decimalPad)
                            }.focused($focusedElm, equals: .numbers)
                            .onChange(of: formData.cost) {newVal in
                                if !formData.manualMode {
                                    let avgCost = formData.numRecords == 0 ? 0 : newVal / Double(formData.numRecords)
                                    for view in formData.records {
                                        view.record.cost = avgCost
                                    }
                                }
                            }
                            HStack {
                                Text("Value: ")
                                TextField("Value", value: $formData.value, formatter: currencyFormatter){}.keyboardType(.decimalPad)
                            }.focused($focusedElm, equals: .numbers)
                            .onChange(of: formData.value) {newVal in
                                if !formData.manualMode {
                                    let avgValue = formData.numRecords == 0 ? 0 : newVal / Double(formData.numRecords)
                                    for view in formData.records {
                                        view.record.value = avgValue
                                    }
                                }
                            }
                            Group {
                                Toggle(isOn: $formData.isCompilation, label: {Text("Compilation: ")}).onChange(of: formData.isCompilation) {newValue in
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.isCompilation = newValue
                                        }
                                    }
                                }
                                Toggle(isOn: $formData.isMix, label: {Text("Mix: ")}).onChange(of: formData.isMix) {newValue in
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.isMix = newValue
                                        }
                                    }
                                }
                                Toggle(isOn: $formData.isGH, label: {Text("Greatest Hits: ")}).onChange(of: formData.isGH) {newValue in
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.isGH = newValue
                                        }
                                    }
                                }
                                Toggle(isOn: $formData.isCollection, label: {Text("Collection: ")}).onChange(of: formData.isCollection) {newValue in
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.isCollection = newValue
                                        }
                                    }
                                }
                                Toggle(isOn: $formData.isLive, label: {Text("Live: ")}).onChange(of: formData.isLive) {newValue in
                                    if !formData.manualMode {
                                        for record in formData.records {
                                            record.record.isLive = newValue
                                        }
                                    }
                                }
                            }
                            
                            Section(header: Text("Artists:").foregroundColor(.brown)) {
                                if formData.artists.count >= 1 {
                                    VStack {
                                        ForEach(formData.artists, id: \.self) {artist in
                                            Text(artist).frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                }
                                if !formData.isMix {
                                    HStack {
                                        Text("Artist: ")
                                        TextField(text: $newArtistName, prompt: Text("Artist Name")){}
                                            .focused($focusedElm, equals: .text)
                                    }
                                    .disableAutocorrection(true)
                                    .onSubmit {
                                        if !formData.manualMode{
                                            if newArtistName != "" {
                                                formData.artists.append(newArtistName)
                                                newArtistName = ""
                                            }
                                        }
                                        
                                        if !formData.isMix {
                                            for view in formData.records {
                                                view.record.artists = Array(Set(view.record.artists + formData.artists))
                                            }
                                        }
                                    }.onChange(of: focusedElm, perform: { _ in
                                        if !formData.manualMode{
                                            if newArtistName != "" {
                                                formData.artists.append(newArtistName)
                                                newArtistName = ""
                                            }
                                        }
                                        
                                        if !formData.isMix {
                                            for view in formData.records {
                                                view.record.artists = Array(Set(view.record.artists + formData.artists))
                                            }
                                        }
                                    })
                                }
                            }
                        }.headerProminence(.increased)
                        
                        if ((min(formData.numRecords - 1, formData.records.count - 1)) >= 0) {
                            Section(header: Text("Records:").foregroundColor(.brown)) {
                                ForEach(0...(min(formData.numRecords - 1, formData.records.count - 1)), id: \.self) {i in
                                    Section(header: Text("Record \(i + 1):")) {
                                        formData.records[i]
                                    }
                                }
                            }.headerProminence(.increased)
                        }
                    }.scrollContentBackground(.hidden)
                }
                .toolbar {
                    if (focusedElm == .numbers) {
                        ToolbarItem(placement: .keyboard) {
                            Button("Done") {
                                focusedElm = nil
                            }
                        }
                    }
                }
            }
            
            .navigationBarItems(trailing: Button(action: {
                if formData.title != "" {
                    var recordsArr = [Record]()
                    for view in formData.records {
                        recordsArr.append(view.record)
                    }
                    model.addBoughtAlbumToStop(isCompilation: formData.isCompilation, isMix: formData.isMix, isGH: formData.isGH, isCollection: formData.isCollection, isLive: formData.isLive, genre: formData.genre, releaseYear: (formData.releaseYearStr == "" ? nil : Int(formData.releaseYearStr)), title: formData.title, label: formData.label, artists: formData.artists, value: formData.value, cost: formData.cost, records: recordsArr)
                }
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                    Text("Finish Album").foregroundColor(.black).bold(true)
                }
            })
        }
        .environmentObject(model)
        .navigationBarBackButtonHidden(true)
    }
}

struct AddStoreAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AddStoreAlbumView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(CatalogerModel())
    }
}
