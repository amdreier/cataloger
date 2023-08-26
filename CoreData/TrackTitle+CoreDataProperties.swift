//
//  TrackTitle+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/26/23.
//
//

import Foundation
import CoreData


extension UniqueTracks.TrackTitle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UniqueTracks.TrackTitle> {
        return NSFetchRequest<UniqueTracks.TrackTitle>(entityName: "TrackTitle")
    }

    @NSManaged public var titleDat: String?
    @NSManaged public var tracks: NSSet?
    @NSManaged public var uniqueTracksDat: UniqueTracks?

}

// MARK: Generated accessors for tracks
extension UniqueTracks.TrackTitle {

    @objc(addTracksObject:)
    @NSManaged public func addToTracks(_ value: Track)

    @objc(removeTracksObject:)
    @NSManaged public func removeFromTracks(_ value: Track)

    @objc(addTracks:)
    @NSManaged public func addToTracks(_ values: NSSet)

    @objc(removeTracks:)
    @NSManaged public func removeFromTracks(_ values: NSSet)

}

extension UniqueTracks.TrackTitle : Identifiable {

}
