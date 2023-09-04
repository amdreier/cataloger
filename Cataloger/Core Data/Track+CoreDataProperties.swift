//
//  Track+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/24/23.
//
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track")
    }

    @NSManaged public var titleDat: String?
    @NSManaged public var artistsDat: [NSString]?
    @NSManaged public var releaseYearDat: Int64
    @NSManaged public var genreDat: String?
    @NSManaged public var isLiveDat: Bool
    @NSManaged public var uniquenessDat: Int64
    @NSManaged public var recordDat: Record?
    @NSManaged public var userWishlistDat: User?
    @NSManaged public var trackTitleDat: UniqueTracks.TrackTitle?
    @NSManaged public var trackTitleAndArtistsDat: UniqueTracks.TrackTitleAndArtists?
    @NSManaged public var trackVersionDat: UniqueTracks.TrackVersion?

    public var title: String {
        titleDat ?? ""
    }
    
    public var artists: [String] {
        artistsDat as? [String] ?? []
    }
    
    public var releaseYear: Int? {
        if releaseYearDat != nil {
            return Int(truncatingIfNeeded: releaseYearDat)
        } else {
            return nil
        }
    }
    
    public var genre: String {
        genreDat ?? ""
    }
    
    public var isLive: Bool {
        isLiveDat ?? false
    }
    
    public var uniqueness: UniqueTracks.Uniqueness {
        let num64 = uniquenessDat ?? 4
        let num = Int(truncatingIfNeeded: num64)
        return UniqueTracks.Uniqueness(rawValue: num) ?? UniqueTracks.Uniqueness.unique
    }
    
    public var record: Record? {
        recordDat ?? nil
    }
}

extension Track : Identifiable {

}
