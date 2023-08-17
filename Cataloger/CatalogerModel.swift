//
//  CataloguerModel.swift
//  Cataloguer
//
//  Created by Alex Dreier on 8/14/23.
//

import Foundation

class CatalogerModel: ObservableObject {
    @Published var user = User()
    @Published var currentTrip: Trip? = Trip(User())
    @Published var stores = [Store]()
    @Published var stop: Int = 0
    
    var testStore = Store()
    var testAlbum = Album(isCompilation: false, isMix: false, isGH: false, isCollection: false, isLive: false, genre: "Swing", releaseYear: 1955, title: "SwingSong", label: "Label", value: 5, cost: 2)
    
    init() {
        testStore.name = "StoreName"
        testStore.location = "location"
        stores.append(testStore)
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
    
    func addBoughtAlbumToTrip(album: Album) {
        do {
            try currentTrip?.addBoughtAlbum(stop: self.stop, album: album)
        } catch {
            
        }
    }
    
    func testFunc() {
        do {
            try currentTrip?.addBoughtAlbum(stop: self.stop, album: testAlbum)
        } catch {
            
        }
    }
    
    func getNewAlbumList() -> [Album] {
        var albums: [Album]
        
        if currentTrip == nil || currentTrip!.newAlbums.isEmpty {
            albums = [Album]()
        } else {
            albums = currentTrip?.newAlbums[self.stop] ?? [Album]()
        }
        
        return albums
    }
}
