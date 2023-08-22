//
//  CatalogerModel.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/14/23.
//

import Foundation

class CatalogerModel: ObservableObject {
    @Published var user = User()
    @Published var currentTrip: Trip? = nil
    @Published var stores = [Store]()
    @Published var selectedStore: Store? = nil
    @Published var stop: Int = 0
    @Published var newAlbums = [Album]()
    @Published var soldAlbums = [Album]()
//    @Published var editingAlbum: Album? = nil
    
    /*
        Need to add other data for adding stores to trips
     */
    
    var testStore = Store()
    var testStore2 = Store()
    var testAlbum = Album(isCompilation: false, isMix: false, isGH: false, isCollection: false, isLive: false, genre: "Swing", releaseYear: 1955, title: "SwingSong", label: "Label", value: 5, cost: 2)
    
    init() {
        testAlbum.records = [Record(isCompilation: false, isMix: false, isGH: false, isCollection: false, isLive: false, genre: "Swing", releaseYear: 1995, title: "record1", label: "Label", speed: 33, value: 5, cost: 2, album: testAlbum)]
        
        testStore.name = "Store1"
        testStore.location = "location1"
        stores.append(testStore)
        
        testStore2.name = "Store2"
        testStore2.location = "location2"
        stores.append(testStore2)
    }
    
    func startTrip() {
        endTrip()
        stop = 0
        currentTrip = user.startTrip()
    }
    
    func endTrip() {
        currentTrip?.endTrip()
        currentTrip = nil
    }
    
    func addStore(store: Store) {
        stores.append(store)
    }
    
    func addBoughtAlbumToStop(isCompilation: Bool, isMix: Bool, isGH: Bool, isCollection: Bool, isLive: Bool, genre: String, releaseYear: Int?, title: String, label: String, artists: [String], value: Double, cost: Double, records: [Record]) {
        newAlbums.append(Album(isCompilation: isCompilation, isMix: isMix, isGH: isGH, isCollection: isCollection, isLive: isLive, genre: genre, releaseYear: releaseYear, title: title, label: label, artists: artists, value: value, cost: cost, records: records))
    }
    
    
    func finishStopTrip() {
        if selectedStore != nil {
            currentTrip?.addStop(store: selectedStore!) // add additional needed data
        }
    }
    
    func testFunc() {
        newAlbums.append(testAlbum)
    }
    
    func selectStore(store: Store) {
        selectedStore = store
    }
    
    func addStop() {
        if selectedStore != nil {
            currentTrip?.addStop(store: selectedStore!, albumsBought: newAlbums, albumsSold: soldAlbums) // need to add other data to func
        }
        
        resetStore()
    }
    
    func deselectStore() {
        selectedStore = nil
    }
    
    func resetStore() {
        selectedStore = nil
        newAlbums = [Album]()
        soldAlbums = [Album]()
    }
}
