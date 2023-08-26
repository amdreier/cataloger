//
//  TrackVersion+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/26/23.
//
//

import Foundation
import CoreData


extension UniqueTracks.TrackVersion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UniqueTracks.TrackVersion> {
        return NSFetchRequest<UniqueTracks.TrackVersion>(entityName: "TrackVersion")
    }

    @NSManaged public var artistsDat: [String]?
    @NSManaged public var isLiveDat: Bool
    @NSManaged public var releaseYearDat: Int64
    @NSManaged public var titleDat: String?
    @NSManaged public var tracksDat: NSSet?
    @NSManaged public var uniqueTracksDat: UniqueTracks?

}

// MARK: Generated accessors for tracksDat
extension UniqueTracks.TrackVersion {

    @objc(addTracksDatObject:)
    @NSManaged public func addToTracksDat(_ value: Track)

    @objc(removeTracksDatObject:)
    @NSManaged public func removeFromTracksDat(_ value: Track)

    @objc(addTracksDat:)
    @NSManaged public func addToTracksDat(_ values: NSSet)

    @objc(removeTracksDat:)
    @NSManaged public func removeFromTracksDat(_ values: NSSet)

}

extension UniqueTracks.TrackVersion : Identifiable {

}
