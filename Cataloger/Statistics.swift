//
//  Statistics.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/15/23.
//

import Foundation

class Statistics {
    var timeSpent: Int = 0
    var recordsBought: Int = 0
    var recordsSold: Int = 0
    var totalSpent: Double = 0
    var totalEarned: Double = 0
    var totalTrips: Int = 0
    var tripsBuying: Int = 0
    var tripsSelling: Int = 0
    var travelTime: Int = 0
    
    /* Calculated Metrics */
    var totalRecords: Int = 0
    var pricePerRecord: Double = 0
    var averageSellPrice: Double = 0
    
    func updateStatistics(timeSpent: Int, recordsBought: Int, recordsSold: Int, totalSpent: Double, totalEarned: Double, isTrip: Bool, travelTime: Int) {
        self.timeSpent += timeSpent
        self.recordsBought += recordsBought
        self.recordsSold += recordsSold
        self.totalSpent += totalSpent
        self.totalEarned += totalEarned
        self.totalTrips += isTrip ? 1 : 0
        self.tripsBuying += recordsBought > 0 ? 1 : 0
        self.tripsSelling += recordsSold > 0 ? 1 : 0
        self.travelTime += travelTime
    }
    
    func calculateCalcMetrics() {
        self.totalRecords = self.recordsBought - self.recordsSold
        self.pricePerRecord = self.recordsBought == 0 ? 0 : self.totalSpent / Double (self.recordsBought)
        self.averageSellPrice = self.recordsSold == 0 ? 0 : self.totalEarned / Double (self.recordsSold)
    }
}
