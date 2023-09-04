//
//  Stop+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/25/23.
//
//

import Foundation
import CoreData


extension Trip.Stop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip.Stop> {
        return NSFetchRequest<Trip.Stop>(entityName: "Stop")
    }

    @NSManaged public var timeSpentDat: Int64
    @NSManaged public var moneySpentDat: Double
    @NSManaged public var moneyEarnedDat: Double
    @NSManaged public var timeTraveledDat: Int64
    @NSManaged public var storeDat: Store?
    @NSManaged public var newAlbumsDat: NSSet?
    @NSManaged public var soldAlbumsDat: NSSet?
    @NSManaged public var tripDat: Trip?

}

// MARK: Generated accessors for newAlbumsDat
extension Trip.Stop {

    @objc(addNewAlbumsDatObject:)
    @NSManaged public func addToNewAlbumsDat(_ value: Album)

    @objc(removeNewAlbumsDatObject:)
    @NSManaged public func removeFromNewAlbumsDat(_ value: Album)

    @objc(addNewAlbumsDat:)
    @NSManaged public func addToNewAlbumsDat(_ values: NSSet)

    @objc(removeNewAlbumsDat:)
    @NSManaged public func removeFromNewAlbumsDat(_ values: NSSet)

}

// MARK: Generated accessors for soldAlbumsDat
extension Trip.Stop {

    @objc(addSoldAlbumsDatObject:)
    @NSManaged public func addToSoldAlbumsDat(_ value: Album)

    @objc(removeSoldAlbumsDatObject:)
    @NSManaged public func removeFromSoldAlbumsDat(_ value: Album)

    @objc(addSoldAlbumsDat:)
    @NSManaged public func addToSoldAlbumsDat(_ values: NSSet)

    @objc(removeSoldAlbumsDat:)
    @NSManaged public func removeFromSoldAlbumsDat(_ values: NSSet)

}

extension Trip.Stop : Identifiable {

}
