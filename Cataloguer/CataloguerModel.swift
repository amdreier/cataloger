//
//  CataloguerModel.swift
//  Cataloguer
//
//  Created by Alex Dreier on 8/14/23.
//

import Foundation

class CataloguerModel: ObservableObject {
    @Published var user = User()
    @Published var currentTrip: Trip? = Trip(User())
    @Published var stores = [Store]()
    
    var testStore = Store()
    
    init() {
        testStore.name = "testStore"
        testStore.location = "location"
        stores.append(testStore)
    }
    
    func startTrip() {
        endTrip()
        currentTrip = user.startTrip()
    }
    
    func endTrip() {
        currentTrip?.endTrip()
        currentTrip = nil
    }
    
    func addStore(store: Store) {
        stores.append(store)
    }
}
