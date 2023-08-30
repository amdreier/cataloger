//
//  CatalogerModel.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/14/23.
//

import Foundation
import CoreData

@objc(CatalogerModel)
class CatalogerModel: NSManagedObject {
//    @Published var user = User()
    @Published var currentTrip: Trip? = nil
//    @Published var stores = [Store]()
    @Published var selectedStore: Store? = nil
    @Published var stop: Int = 0
    @Published var newAlbums = [Album]()
    @Published var soldAlbums = [Album]()
//    @Published var editingAlbum: Album? = nil
    
    let context: NSManagedObjectContext? = nil
    
    init(context: NSManagedObjectContext) {
        
//        print("CM")
        super.init(entity: NSEntityDescription.entity(forEntityName: "CatalogerModel", in: context)!, insertInto: context)
        
        self.context = context
    }
    
    func startTrip() {
        print("")
        endTrip()
        print("et")
        stop = 0
        print("sz")
        currentTrip = user.startTrip()
        print("ct")
    }
    
    func endTrip() {
        if currentTrip == nil {
            return
        }
        
        if currentTrip!.stops.isEmpty {
            user.tripsDat = NSSet(array: user.trips.dropLast(1))
            return
        }
        
        currentTrip?.endTrip()
        do {
            try context?.save()
        } catch {
            print("Error saving trip")
        }
        currentTrip = nil
    }
    
    func addStore(store: Store) {
        addToStoresDat(store)
    }
    
    func addBoughtAlbumToStop(isCompilation: Bool, isMix: Bool, isGH: Bool, isCollection: Bool, isLive: Bool, genre: String, releaseYear: Int?, title: String, label: String, artists: [String], value: Double, cost: Double, records: [Record]) {
        newAlbums.append(Album(context: context!, isCompilation: isCompilation, isMix: isMix, isGH: isGH, isCollection: isCollection, isLive: isLive, genre: genre, releaseYear: releaseYear, title: title, label: label, artists: artists, value: value, cost: cost, records: records))
    }
    
    
    func finishStopTrip() {
        if selectedStore != nil {
            currentTrip?.addStop(store: selectedStore!) // add additional needed data
        }
    }

    func selectStore(store: Store) {
        selectedStore = store
    }
    
    func addStop(timeSpent: Int, timeTraveled: Int) {
        if selectedStore != nil {
            currentTrip?.addStop(store: selectedStore!, albumsBought: newAlbums, albumsSold: soldAlbums, timeTraveled: timeTraveled, timeSpent: timeSpent) // need to add other data to func
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
