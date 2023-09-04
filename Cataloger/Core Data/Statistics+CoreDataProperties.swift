//
//  Statistics+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/24/23.
//
//

import Foundation
import CoreData


extension Statistics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Statistics> {
        return NSFetchRequest<Statistics>(entityName: "Statistics")
    }

    @NSManaged public var timeSpentDat: Int64
    @NSManaged public var recordsBoughtDat: Int64
    @NSManaged public var recordsSoldDat: Int64
    @NSManaged public var tripsBuyingDat: Int64
    @NSManaged public var totalSpentDat: Double
    @NSManaged public var totalEarnedDat: Double
    @NSManaged public var totalTripsDat: Int64
    @NSManaged public var tripsSellingDat: Int64
    @NSManaged public var travelTimeDat: Int64
    @NSManaged public var totalCostDat: Double
    @NSManaged public var totalValueDat: Double
    @NSManaged public var totalRecordsDat: Int64
    @NSManaged public var pricePerRecordDat: Double
    @NSManaged public var averageSellPriceDat: Double
    @NSManaged public var storeDat: NSSet?
    @NSManaged public var userDat: User?
    
    public var timeSpent: Int {
        if timeSpentDat != nil {
            return Int(truncatingIfNeeded: timeSpentDat)
        } else {
            return 0
        }
    }
    
    public var recordsBought: Int {
        if recordsBoughtDat != nil {
            return Int(truncatingIfNeeded: recordsBoughtDat)
        } else {
            return 0
        }
    }
    
    public var recordsSold: Int {
        if recordsSoldDat != nil {
            return Int(truncatingIfNeeded: recordsSoldDat)
        } else {
            return 0
        }
    }
    
    public var totalSpent: Double {
        totalSpentDat ?? 0
    }
    
    public var totalEarned: Double {
        totalEarnedDat ?? 0
    }
    
    public var totalTrips: Int {
        if totalTripsDat != nil {
            return Int(truncatingIfNeeded: totalTripsDat)
        } else {
            return 0
        }
    }
    
    public var tripsBuying: Int {
        if tripsBuyingDat != nil {
            return Int(truncatingIfNeeded: tripsBuyingDat)
        } else {
            return 0
        }
    }
    
    public var tripsSelling: Int {
        if tripsSellingDat != nil {
            return Int(truncatingIfNeeded: tripsSellingDat)
        } else {
            return 0
        }
    }
    
    public var travelTime: Int {
        if travelTimeDat != nil {
            return Int(truncatingIfNeeded: travelTimeDat)
        } else {
            return 0
        }
    }
    
    public var totalCost: Double {
        totalCostDat ?? 0
    }
    
    public var totalValue: Double {
        totalValueDat ?? 0
    }
    
    public var totalRecords: Int {
        if totalRecordsDat != nil {
            return Int(truncatingIfNeeded: totalRecordsDat)
        } else {
            return 0
        }
    }
    
    public var pricePerRecord: Double {
        pricePerRecordDat ?? 0
    }
    
    public var averageSellPrice: Double {
        averageSellPriceDat ?? 0
    }

}

// MARK: Generated accessors for storeDat
extension Statistics {

    @objc(addStoreDatObject:)
    @NSManaged public func addToStoreDat(_ value: Store)

    @objc(removeStoreDatObject:)
    @NSManaged public func removeFromStoreDat(_ value: Store)

    @objc(addStoreDat:)
    @NSManaged public func addToStoreDat(_ values: NSSet)

    @objc(removeStoreDat:)
    @NSManaged public func removeFromStoreDat(_ values: NSSet)

}

extension Statistics : Identifiable {

}
