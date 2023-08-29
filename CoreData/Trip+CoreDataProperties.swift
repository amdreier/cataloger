//
//  Trip+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/25/23.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var dateDat: Date?
    @NSManaged public var isFinishedDat: Bool
    @NSManaged public var totalTimeSpentDat: Int64
    @NSManaged public var totalMoneySpentDat: Double
    @NSManaged public var totalMoneyEarnedDat: Double
    @NSManaged public var totalTimeTraveledDat: Int64
    @NSManaged public var numRecordsBoughtDat: Int64
    @NSManaged public var numRecordsSoldDat: Int64
    @NSManaged public var totalValueSoldDat: Double
    @NSManaged public var totalCostSoldDat: Double
    @NSManaged public var totalValueAddedDat: Double
    @NSManaged public var pricePerRecordDat: Double
    @NSManaged public var averageSellPriceDat: Double
    @NSManaged public var userDat: User?
    @NSManaged public var stopsDat: NSSet?
    
    public var date: Date {
        dateDat ?? Date()
    }
    
    public var isFinished: Bool {
        isFinishedDat ?? false
    }
    
    public var stops: [Stop] {
        let stopSet = stopsDat as? Set<Stop> ?? []
        
        return stopSet.sorted {
            $0.store!.name < $1.store!.name
        }
    }
    
    public var totalTimeSpent: Int {
        if totalTimeSpentDat != nil {
            return Int(truncatingIfNeeded: totalTimeSpentDat)
        } else {
            return 0
        }
    }
    
    public var totalMoneySpent: Double {
        totalMoneySpentDat ?? 0
    }
    
    public var totalMoneyEarned: Double {
        totalMoneyEarnedDat ?? 0
    }
    
    public var totalTimeTraveled: Int {
        if totalTimeTraveledDat != nil {
            return Int(truncatingIfNeeded: totalTimeTraveledDat)
        } else {
            return 0
        }
    }
    
    public var numRecordsBought: Int {
        if numRecordsBought != nil {
            return Int(truncatingIfNeeded: numRecordsBoughtDat)
        } else {
            return 0
        }
    }
    
    public var numRecordsSold: Int {
        if numRecordsSoldDat != nil {
            return Int(truncatingIfNeeded: numRecordsSoldDat)
        } else {
            return 0
        }
    }
    
    public var totalValueSold: Double {
        totalValueSoldDat ?? 0
    }
    
    public var totalCostSold: Double {
        totalCostSoldDat ?? 0
    }
    
    public var totalValueAdded: Double {
        totalValueAddedDat ?? 0
    }
    
    public var pricePerRecord: Double {
        pricePerRecordDat ?? 0
    }
    
    public var averageSellPrice: Double {
        averageSellPriceDat ?? 0
    }
    
    public var user: User {
        userDat ?? User(context: context!)
    }
}

// MARK: Generated accessors for stopsDat
extension Trip {

    @objc(addStopsDatObject:)
    @NSManaged public func addToStopsDat(_ value: Stop)

    @objc(removeStopsDatObject:)
    @NSManaged public func removeFromStopsDat(_ value: Stop)

    @objc(addStopsDat:)
    @NSManaged public func addToStopsDat(_ values: NSSet)

    @objc(removeStopsDat:)
    @NSManaged public func removeFromStopsDat(_ values: NSSet)

}

extension Trip : Identifiable {

}
