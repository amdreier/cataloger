//
//  Trip.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/10/23.
//

import Foundation
import CoreData

@objc(Trip)
class Trip: NSManagedObject {
    let context: NSManagedObjectContext? = nil
    
    @objc(Stop)
    class Stop: NSManagedObject {
        var store: Store? = nil
        var newAlbums = [Album]()
        var soldAlbums = [Album]()
        
        var timeSpent: Int = 0
        var moneySpent: Double = 0
        var moneyEarned: Double = 0
        var timeTraveled: Int = 0
        
        let context: NSManagedObjectContext? = nil
        
        init(context: NSManagedObjectContext, store: Store, newAlbums: [Album] = [Album](), soldAlbums: [Album] = [Album](), timeSpent: Int, moneySpent: Double, moneyEarned: Double, timeTraveled: Int) {
            super.init(entity: NSEntityDescription.entity(forEntityName: "Stop", in: context)!, insertInto: context)
            
            self.context = context
            
            self.store = store
            self.newAlbums = newAlbums
            self.soldAlbums = soldAlbums
            self.timeSpent = timeSpent
            self.moneySpent = moneySpent
            self.moneyEarned = moneyEarned
            self.timeTraveled = timeTraveled
        }
        
        @objc
        private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
            super.init(entity: entity, insertInto: context)
            
            self.context = context!
        }
    }
    
//    var isFinished = false              // if the trip is still in progress
//    var stops = [Stop]()              // stores visited in ordered (with duplicates for return stops)
    
    // Need to handle buying or selling only some records in an album
//    var newAlbums = [[Album]]()         // albums bought
//    var soldAlbums = [[Album]]()        // albums sold
    
//    var totalTimeSpent: Int = 0         // total time spent at all stores
//    var timeSpent = [Int]()             // time spent in each store with corresponding array index
//    var moneySpent = [Double]()         // money spent in each store with corresponding array index
//    var moneyEarned = [Double]()        // money earned in each store with corresponding array index
//    var totalMoneySpent: Double = 0     // total money spent at all stores
//    var totalMoneyEarned: Double = 0    // total moeny earned at each store
//    var totalTimeTraveled: Int = 0      // total time spent traveling for this trip
//    var timeTraveled = [Int]()          // time traveled from last location to location i
//    var numRecordsBought: Int = 0       // total number of records bought on this trip so far
//    var numRecordsSold: Int = 0         // total number of records sold on this trip so far
    
//    var totalValueSold: Double = 0
//    var totalCostSold: Double = 0
//    var totalValueAdded: Double = 0
    
//    var pricePerRecord: Double = 0      // average price per record bought
//    var averageSellPrice: Double = 0    // average sell price for each record sold
    
//    var user: User = User()
    
    init(context: NSManagedObjectContext, _ user: User) {
        super.init(entity: NSEntityDescription.entity(forEntityName: "Trip", in: context)!, insertInto: context)
        
        self.context = context
        self.userDat = user
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        
        self.context = context!
    }
    
    enum illegalArgument: Error {
        case illegalStore(message: String)
        case illegalAlbum(message: String)
    }
    
    /// - Description: Adds Stop  to this Trip
    /// - Parameters:
    ///   - store: Store to add to Trip, can be duplicate for multiple stops
    ///   - albumsBought: The albums that were bought at this stop so far (can be changed later)
    ///   - albumsSold: The albums that were sold at this stop so far (can be changed later)
    ///   - moneySpent: How much money has been spend at this stop so far (can be changed later)
    ///   - moneyEarned: How much money has been earned at this stop so far (can be changed later)
    ///   - timeTraveled: How long it took to travel to this stop so far (can be changed later)
    ///   - timeSpent: How much time has been spent at this stop so far (can be changed later)
    func addStop(store: Store, albumsBought: [Album] = [], albumsSold: [Album] = [], timeTraveled: Int = 0, timeSpent: Int = 0) {
        var moneySpent: Double = 0
        var moneyEarned: Double = 0
        
        var valueAdded: Double = 0
        var costSold: Double = 0
        
            
        for album in albumsBought {
            moneySpent += album.cost
            valueAdded += album.value
        }
        
        for album in albumsSold {
            moneyEarned += album.value
            costSold += album.cost
        }
        
        let stop = Stop(context: context!, store: store, newAlbums: albumsBought, soldAlbums: albumsSold, timeSpent: timeSpent, moneySpent: moneySpent, moneyEarned: moneyEarned, timeTraveled: timeTraveled)
        addToStopsDat(stop)
        self.totalMoneySpentDat += moneySpent
        self.totalMoneyEarnedDat += moneyEarned
        self.totalValueAddedDat += valueAdded
        self.totalCostSoldDat += costSold
        self.totalTimeTraveledDat += Int64(timeTraveled)
        self.totalTimeSpentDat += Int64(timeSpent)
        self.numRecordsBoughtDat += Int64(Album.recordCount(albumsBought))
        self.numRecordsSoldDat += Int64(Album.recordCount(albumsSold))
        
        updateAverages()
    }
    
    
    /// - Description: Ends the Trip, updates User catalog, unique tracks, and wishlist, updates Store metrics
    func endTrip() {
        self.isFinishedDat = true
        for stop in stops {
            stop.store!.statistics.updateStatistics(timeSpent: stop.timeSpent, recordsBought: Album.recordCount(stop.newAlbums), recordsSold: Album.recordCount(stop.soldAlbums), totalSpent: stop.moneySpent, totalEarned: stop.moneyEarned, isTrip: true, travelTime: stop.timeTraveled)
        }
        
        user.statistics.updateStatistics(timeSpent: totalTimeSpent, recordsBought: numRecordsBought, recordsSold: numRecordsSold, totalSpent: totalMoneySpent, totalEarned: totalMoneyEarned, isTrip: true, travelTime: totalTimeTraveled, costSold: totalCostSold, valueAdded: totalValueAdded, valueSold: totalValueSold)
        for stop in stops {
            for album in stop.newAlbums {
                user.catalog.addAlbum(album: album)
            }
        }
        for stop in stops {
            for album in stop.soldAlbums {
                user.catalog.removeAlbum(album: album)
            }
        }
    }
    
    /// - Description: Adds a bought album to the list for the corresponding index
    /// - Parameters:
    ///   - stop: Which stop/store in the Trip to add the Album
    ///   - album: The Album to add to the stop
    /// - Throws: illegalStore exception if stop index out of bounds
    func addBoughtAlbum(stop: Int, album: Album) throws {
        if stop >= stops.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when adding bought album: \(stop)")
        }
        
        self.stops[stop].addToNewAlbumsDat(album)
        self.numRecordsBoughtDat += Int64(album.records.count)
        self.stops[stop].moneySpentDat += album.cost
        self.totalMoneySpentDat += album.cost
        
        updateAverages()
    }
    
    /// - Description: Adds a sold album to the list for the corresponding index
    /// - Parameters:
    ///   - stop: Which stop/store in the Trip to add the Album
    ///   - album: The Album to add to the stop
    /// - Throws: illegalStore exception if stop index out of bounds
    func addSoldAlbum(stop: Int, album: Album, value: Double) throws {
        if stop >= stops.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when adding sold album: \(stop)")
        }
        
        self.stops[stop].addToSoldAlbumsDat(album)
        self.numRecordsSoldDat += Int64(album.records.count)
        self.stops[stop].moneyEarnedDat += value
        self.totalMoneyEarnedDat += value
        
        updateAverages()
    }
    
    
    /// - Description: Removes bought album from specified store and at specified index
    /// - Parameters:
    ///   - stop: Index of stop to remove from
    ///   - album: Album index to remove
    /// - Throws: illegalStore exception if stop index out of bounds and illegalAlbum if album index out of bounds
    func removeBoughtAlbum(stop: Int, album: Album) throws {
        if stop >= stops.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when removing bought album: \(stop)")
        }
//
//        if album >= stops[stop].newAlbums.count || album < 0 {
//            throw illegalArgument.illegalAlbum(message: "Album outside of Album range when removing bought album: \(album)")
//        }
        
        if stops[stop].newAlbums.contains(album) {
            
            stops[stop].removeFromNewAlbumsDat(album)
            
            self.numRecordsBoughtDat -= Int64(album.records.count)
            self.stops[stop].moneySpentDat -= album.cost
            self.totalMoneySpentDat -= album.cost
            
            updateAverages()
        }
    }
    
    /// - Description: Removes sold album from specified store and at specified index
    /// - Parameters:
    ///   - stop: Index of stop to remove from
    ///   - album: Album index to remove
    /// - Throws: illegalStore exception if stop index out of bounds and illegalAlbum if album index out of bounds
    func removeSoldAlbum(stop: Int, album: Album, value: Double) throws {
        if stop >= stops.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when removing bought album: \(stop)")
        }
        
//        if album >= stops[stop].soldAlbums.count || album < 0 {
//            throw illegalArgument.illegalAlbum(message: "Album outside of Album range when removing bought album: \(album)")
//        }
        
        if stops[stop].soldAlbums.contains(album) {
            
            stops[stop].removeFromSoldAlbumsDat(album)
            
            self.numRecordsSoldDat -= Int64(album.records.count)
            self.stops[stop].moneyEarnedDat -= value
            self.totalMoneyEarnedDat -= value
            
            updateAverages()
        }
    }
    
    /// - Description: Updates the averages for price of records bought and sold
    func updateAverages() {
        self.pricePerRecordDat = self.numRecordsBought == 0 ? 0 : (Double (self.totalMoneySpent)) / (Double (self.numRecordsBought))
        self.averageSellPriceDat = self.numRecordsSold == 0 ? 0 : (Double (self.totalMoneyEarned)) / (Double (self.numRecordsSold))
    }
    
    /// - Description: Sets timeSpent for a stop
    /// - Parameters:
    ///   - stop: Stop index to set
    ///   - newValue: New timeSpent value
    /// - Throws: illegalStore exception if stop index out of bounds
    func setTimeSpent(stop: Int, newValue: Int) throws {
        if stop >= stops.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when editing timeSpent: \(stop)")
        }
        
        self.stops[stop].timeSpent = newValue
    }
    
    /// - Description: Sets moneySpent for a stop
    /// - Parameters:
    ///   - stop: Stop index to set
    ///   - newValue: New moneySpent value
    /// - Throws: illegalStore exception if stop index out of bounds
    func setMoneySpent(stop: Int, newValue: Double) throws {
        if stop >= stops.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when editing moneySpent: \(stop)")
        }
        
        self.totalMoneySpentDat -= stops[stop].moneySpent
        self.stops[stop].moneySpentDat = newValue
        self.totalMoneySpentDat += stops[stop].moneySpent
        
        updateAverages()
    }
    
    /// - Description: Sets moneyEarned for a stop
    /// - Parameters:
    ///   - stop: Stop index to set
    ///   - newValue: New moneyEarned value
    /// - Throws: illegalStore exception if stop index out of bounds
    func setMoneyEarned(stop: Int, newValue: Double) throws {
        if stop >= stops.count || stop < 0 {
            throw illegalArgument.illegalStore(message: "Stop outside of Stops range when editing moneyEarned: \(stop)")
        }
        
        self.totalMoneyEarnedDat -= stops[stop].moneyEarned
        self.stops[stop].moneyEarnedDat = newValue
        self.totalMoneyEarnedDat += stops[stop].moneyEarned
        
        updateAverages()
    }
    
    /// - Description: Sets totalTimeTraveled
    /// - Parameter newValue: Value to give to TotalTimeTraveled
    func setTotalTimeTraveled(newValue: Int) {
        self.totalTimeTraveledDat = Int64(newValue)
    }
}
