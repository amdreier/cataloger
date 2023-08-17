//
//  Trip.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/10/23.
//

import Foundation

struct Trip: CustomStringConvertible {
    var isFinished = false              // if the trip is still in progress
    var stores = [Store]()              // stores visited in ordered (with duplicates for return stops)
    
    // Need to handle buying or selling only some records in an album
    var newAlbums = [[Album]]()         // albums bought
    var soldAlbums = [[Album]]()        // albums sold
    
    var totalTimeSpent: Int = 0         // total time spent at all stores
    var timeSpent = [Int]()             // time spent in each store with corresponding array index
    var moneySpent = [Double]()         // money spent in each store with corresponding array index
    var moneyEarned = [Double]()        // money earned in each store with corresponding array index
    var totalMoneySpent: Double = 0     // total money spent at all stores
    var totalMoneyEarned: Double = 0    // total moeny earned at each store
    var totalTimeTraveled: Int = 0      // total time spent traveling for this trip
    var timeTraveled = [Int]()          // time traveled from last location to location i
    var numRecordsBought: Int = 0       // total number of records bought on this trip so far
    var numRecordsSold: Int = 0         // total number of records sold on this trip so far
    
    var pricePerRecord: Double = 0      // average price per record bought
    var averageSellPrice: Double = 0    // average sell price for each record sold
    
    var description: String {
        String(numRecordsBought)
    }
    
    var user: User
    
    init(_ user: User) {
        self.user = user
    }
    
    enum illegalArgument: Error {
        case illegalStore(message: String)
        case illegalAlbum(message: String)
    }
    
    /// - Description: Adds Store to this Trip
    /// - Parameters:
    ///   - store: Store to add to Trip, can be duplicate for multiple stops
    ///   - albumsBought: The albums that were bought at this stop so far (can be changed later)
    ///   - albumsSold: The albums that were sold at this stop so far (can be changed later)
    ///   - moneySpent: How much money has been spend at this stop so far (can be changed later)
    ///   - moneyEarned: How much money has been earned at this stop so far (can be changed later)
    ///   - timeTraveled: How long it took to travel to this stop so far (can be changed later)
    ///   - timeSpent: How much time has been spent at this stop so far (can be changed later)
    mutating func addStore(store: Store, albumsBought: [Album] = [], albumsSold: [Album] = [], moneySpent: Double = 0, moneyEarned: Double = 0, timeTraveled: Int = 0, timeSpent: Int = 0) {
        self.stores.append(store)
        self.newAlbums.append(albumsBought)
        self.soldAlbums.append(albumsSold)
        self.moneySpent.append(moneySpent)
        self.moneyEarned.append(moneyEarned)
        self.totalMoneySpent += moneySpent
        self.totalMoneyEarned += moneyEarned
        self.totalTimeTraveled += timeTraveled
        self.timeTraveled.append(timeTraveled)
        self.totalTimeSpent += timeSpent
        self.timeSpent.append(timeSpent)
        self.numRecordsBought += Album.recordCount(albumsBought)
        self.numRecordsSold += Album.recordCount(albumsSold)
        
        updateAverages()
    }
    
    
    /// - Description: Ends the Trip, updates User catalogue, unique tracks, and wishlist, updates Store metrics
    mutating func endTrip() {
        self.isFinished = true
        var i = 0
        for store in stores {
            store.statistics.updateStatistics(timeSpent: timeSpent[i], recordsBought: Album.recordCount(newAlbums[i]), recordsSold: Album.recordCount(soldAlbums[i]), totalSpent: moneySpent[i], totalEarned: moneyEarned[i], isTrip: true, travelTime: timeTraveled[i])
            i += 1
        }
        
        user.statistics.updateStatistics(timeSpent: totalTimeSpent, recordsBought: numRecordsBought, recordsSold: numRecordsSold, totalSpent: totalMoneySpent, totalEarned: totalMoneyEarned, isTrip: true, travelTime: totalTimeTraveled)
        for albums in newAlbums {
            for album in albums {
                user.catalogue.addAlbum(album: album)
            }
        }
        for albums in soldAlbums {
            for album in albums {
                user.catalogue.removeAlbum(album: album)
            }
        }
    }
    
    /// - Description: Adds a bought album to the list for the corresponding index
    /// - Parameters:
    ///   - stop: Which stop/store in the Trip to add the Album
    ///   - album: The Album to add to the stop
    /// - Throws: illegalStore exception if stop index out of bounds
    mutating func addBoughtAlbum(stop: Int, album: Album) throws {
        if stop >= stores.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when adding bought album: \(stop)")
        }
        
        self.newAlbums[stop].append(album)
        self.numRecordsBought += album.records.count
        self.moneySpent[stop] += album.cost
        self.totalMoneySpent += album.cost
        
        updateAverages()
    }
    
    /// - Description: Adds a sold album to the list for the corresponding index
    /// - Parameters:
    ///   - stop: Which stop/store in the Trip to add the Album
    ///   - album: The Album to add to the stop
    /// - Throws: illegalStore exception if stop index out of bounds
    mutating func addSoldAlbum(stop: Int, album: Album, value: Double) throws {
        if stop >= stores.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when adding sold album: \(stop)")
        }
        
        self.soldAlbums[stop].append(album)
        self.numRecordsSold += album.records.count
        self.moneyEarned[stop] += value
        self.totalMoneyEarned += value
        
        updateAverages()
    }
    
    
    /// - Description: Removes bought album from specified store and at specified index
    /// - Parameters:
    ///   - stop: Index of stop to remove from
    ///   - album: Album index to remove
    /// - Throws: illegalStore exception if stop index out of bounds and illegalAlbum if album index out of bounds
    mutating func removeBoughtAlbum(stop: Int, album: Int) throws {
        if stop >= stores.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when removing bought album: \(stop)")
        }
        
        if album >= newAlbums.count || album < 0 {
            throw illegalArgument.illegalAlbum(message: "Album outside of Album range when removing bought album: \(album)")
        }
        
        let tempAlbum = self.newAlbums[stop].remove(at: album)
        
        self.numRecordsBought -= tempAlbum.records.count
        self.moneySpent[stop] -= tempAlbum.cost
        self.totalMoneySpent -= tempAlbum.cost
        
        updateAverages()
    }
    
    /// - Description: Removes sold album from specified store and at specified index
    /// - Parameters:
    ///   - stop: Index of stop to remove from
    ///   - album: Album index to remove
    /// - Throws: illegalStore exception if stop index out of bounds and illegalAlbum if album index out of bounds
    mutating func removeSoldAlbum(stop: Int, album: Int, value: Double) throws {
        if stop >= stores.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when removing bought album: \(stop)")
        }
        
        if album >= newAlbums.count || album < 0 {
            throw illegalArgument.illegalAlbum(message: "Album outside of Album range when removing bought album: \(album)")
        }
        
        let tempAlbum = self.soldAlbums[stop].remove(at: album)
        
        self.numRecordsSold -= tempAlbum.records.count
        self.moneyEarned[stop] -= value
        self.totalMoneyEarned -= value
        
        updateAverages()
    }
    
    /// - Description: Updates the averages for price of records bought and sold
    mutating func updateAverages() {
        self.pricePerRecord = (Double (self.totalMoneySpent)) / (Double (self.numRecordsBought))
        self.averageSellPrice = (Double (self.totalMoneySpent)) / (Double (self.numRecordsSold))
    }
    
    /// - Description: Sets timeSpent for a stop
    /// - Parameters:
    ///   - stop: Stop index to set
    ///   - newValue: New timeSpent value
    /// - Throws: illegalStore exception if stop index out of bounds
    mutating func setTimeSpent(stop: Int, newValue: Int) throws {
        if stop >= stores.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when editing timeSpent: \(stop)")
        }
        
        self.timeSpent[stop] = newValue
    }
    
    /// - Description: Sets moneySpent for a stop
    /// - Parameters:
    ///   - stop: Stop index to set
    ///   - newValue: New moneySpent value
    /// - Throws: illegalStore exception if stop index out of bounds
    mutating func setMoneySpent(stop: Int, newValue: Double) throws {
        if stop >= stores.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when editing moneySpent: \(stop)")
        }
        
        self.totalMoneySpent -= self.moneySpent[stop]
        self.moneySpent[stop] = newValue
        self.totalMoneySpent += self.moneySpent[stop]
        
        updateAverages()
    }
    
    /// - Description: Sets moneyEarned for a stop
    /// - Parameters:
    ///   - stop: Stop index to set
    ///   - newValue: New moneyEarned value
    /// - Throws: illegalStore exception if stop index out of bounds
    mutating func setMoneyEarned(stop: Int, newValue: Double) throws {
        if stop >= stores.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when editing moneyEarned: \(stop)")
        }
        
        self.totalMoneyEarned -= self.moneyEarned[stop]
        self.moneyEarned[stop] = newValue
        self.totalMoneyEarned += self.moneyEarned[stop]
        
        updateAverages()
    }
    
    /// - Description: Sets totalTimeTraveled
    /// - Parameter newValue: Value to give to TotalTimeTraveled
    mutating func setTotalTimeTraveled(newValue: Int) {
        self.totalTimeTraveled = newValue
    }
}
