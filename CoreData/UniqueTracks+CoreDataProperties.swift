//
//  UniqueTracks+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/26/23.
//
//

import Foundation
import CoreData


extension UniqueTracks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UniqueTracks> {
        return NSFetchRequest<UniqueTracks>(entityName: "UniqueTracks")
    }

    @NSManaged public var catalog: Catalog?
    @NSManaged public var trackTitleAndArtistsDat: NSSet?
    @NSManaged public var trackTitleDat: NSSet?
    @NSManaged public var trackVersionDat: NSSet?

}

// MARK: Generated accessors for trackTitleAndArtistsDat
extension UniqueTracks {

    @objc(addTrackTitleAndArtistsDatObject:)
    @NSManaged public func addToTrackTitleAndArtistsDat(_ value: TrackTitleAndArtist)

    @objc(removeTrackTitleAndArtistsDatObject:)
    @NSManaged public func removeFromTrackTitleAndArtistsDat(_ value: TrackTitleAndArtist)

    @objc(addTrackTitleAndArtistsDat:)
    @NSManaged public func addToTrackTitleAndArtistsDat(_ values: NSSet)

    @objc(removeTrackTitleAndArtistsDat:)
    @NSManaged public func removeFromTrackTitleAndArtistsDat(_ values: NSSet)

}

// MARK: Generated accessors for trackTitleDat
extension UniqueTracks {

    @objc(addTrackTitleDatObject:)
    @NSManaged public func addToTrackTitleDat(_ value: TrackTitle)

    @objc(removeTrackTitleDatObject:)
    @NSManaged public func removeFromTrackTitleDat(_ value: TrackTitle)

    @objc(addTrackTitleDat:)
    @NSManaged public func addToTrackTitleDat(_ values: NSSet)

    @objc(removeTrackTitleDat:)
    @NSManaged public func removeFromTrackTitleDat(_ values: NSSet)

}

// MARK: Generated accessors for trackVersionDat
extension UniqueTracks {

    @objc(addTrackVersionDatObject:)
    @NSManaged public func addToTrackVersionDat(_ value: TrackVersion)

    @objc(removeTrackVersionDatObject:)
    @NSManaged public func removeFromTrackVersionDat(_ value: TrackVersion)

    @objc(addTrackVersionDat:)
    @NSManaged public func addToTrackVersionDat(_ values: NSSet)

    @objc(removeTrackVersionDat:)
    @NSManaged public func removeFromTrackVersionDat(_ values: NSSet)

}

extension UniqueTracks : Identifiable {

}
