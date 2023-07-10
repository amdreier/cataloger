//
//  Trip.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/10/23.
//

import Foundation

struct Trip {
    var isFinished = false
    
    var stores = [Store]()
    
    // Need to handle buying or selling only some records in an album
    var newAlbums = [[Album]]()
    var soldAlbum = [[Album]]()
    
    var timeSpent = [Int]()
    var moneySpent = [Double]()
    var moneyEarned = [Double]()
    var totalTimeTraveled: Int = 0
    
    mutating func addStore(store: Store, albumsBought: [Album] = [], albumsSold: [Album] = [], moneySpend: Double = 0, moneyEarned: Double = 0, timeTraveled: Int = 0, timeSpent: Int = 0) {
        self.stores.append(store)
        // add rest in to relavent arrays and values
    }
}
