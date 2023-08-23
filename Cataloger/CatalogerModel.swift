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
    
    func startTrip() {
        endTrip()
        stop = 0
        currentTrip = user.startTrip()
    }
    
    func endTrip() {
        if currentTrip == nil {
            return
        }
        
        if currentTrip!.stops.isEmpty {
            user.trips = user.trips.dropLast(1)
            return
        }
        
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
