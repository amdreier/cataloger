//
//  Statistics.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/15/23.
//

import Foundation
import CoreData

class Statistics: NSManagedObject {
//    var timeSpent: Int = 0
//    var recordsBought: Int = 0
//    var recordsSold: Int = 0
//    var totalSpent: Double = 0
//    var totalEarned: Double = 0
//    var totalTrips: Int = 0
//    var tripsBuying: Int = 0
//    var tripsSelling: Int = 0
//    var travelTime: Int = 0
//    var totalCost: Double = 0
//    var totalValue: Double = 0
    
    /* Calculated Metrics */
//    var totalRecords: Int = 0
//    var pricePerRecord: Double = 0
//    var averageSellPrice: Double = 0
    
    init(context: NSManagedObjectContext) {
        super.init(entity: NSEntityDescription(), insertInto: context)
    }
    
    func updateStatistics(timeSpent: Int, recordsBought: Int, recordsSold: Int, totalSpent: Double, totalEarned: Double, isTrip: Bool, travelTime: Int, costSold: Double = 0, valueAdded: Double = 0, valueSold: Double = 0) {
        
        self.timeSpentDat += Int64(timeSpent)
        self.recordsBoughtDat += Int64(recordsBought)
        self.recordsSoldDat += Int64(recordsSold)
        self.totalSpentDat += totalSpent
        self.totalEarnedDat += totalEarned
        self.totalTripsDat += isTrip ? 1 : 0
        self.tripsBuyingDat += recordsBought > 0 ? 1 : 0
        self.tripsSellingDat += recordsSold > 0 ? 1 : 0
        self.travelTimeDat += Int64(travelTime)
        
        self.totalCostDat -= costSold
        self.totalCostDat += totalSpent
        
        self.totalValueDat += valueAdded
        self.totalValueDat -= valueSold
        
        calculateCalcMetrics()
    }
    
    func calculateCalcMetrics() {
        self.totalRecordsDat = Int64(self.recordsBought - self.recordsSold)
        self.pricePerRecordDat = self.recordsBought == 0 ? 0 : self.totalSpent / Double (self.recordsBought)
        self.averageSellPriceDat = self.recordsSold == 0 ? 0 : self.totalEarned / Double (self.recordsSold)
    }
}
