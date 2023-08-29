//
//  User+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/24/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var usernameDat: String?
    @NSManaged public var albumWishlistDat: NSSet?
    @NSManaged public var catalogDat: Catalog?
    @NSManaged public var catalogerModelDat: CatalogerModel?
    @NSManaged public var trackWishlistDat: NSSet?
    @NSManaged public var tripsDat: NSSet?
    @NSManaged public var statisticsDat: Statistics?
    
    public var username: String {
        usernameDat ?? ""
    }
    
    public var catalog: Catalog {
        catalogDat ?? Catalog(context: NSManagedObjectContext())
    }
    
    public var albumWishlist: [Album] {
        let albumSet = albumWishlistDat as? Set<Album> ?? []
        
        return albumSet.sorted {
            $0.title < $1.title
        }
    }
    
    public var trackWishlist: [Track] {
        let trackSet = trackWishlistDat as? Set<Track> ?? []
        
        return trackSet.sorted {
            $0.title < $1.title
        }
    }
    
    public var trips: [Trip] {
        let tripSet = tripsDat as? Set<Trip> ?? []
        
        return tripSet.sorted {
            $0.date < $1.date
        }
    }
    
    public var statistics: Statistics {
        statisticsDat ?? Statistics(context: context)
    }
}

// MARK: Generated accessors for albumWishlistDat
extension User {

    @objc(addAlbumWishlistDatObject:)
    @NSManaged public func addToAlbumWishlistDat(_ value: Album)

    @objc(removeAlbumWishlistDatObject:)
    @NSManaged public func removeFromAlbumWishlistDat(_ value: Album)

    @objc(addAlbumWishlistDat:)
    @NSManaged public func addToAlbumWishlistDat(_ values: NSSet)

    @objc(removeAlbumWishlistDat:)
    @NSManaged public func removeFromAlbumWishlistDat(_ values: NSSet)

}

// MARK: Generated accessors for trackWishlistDat
extension User {

    @objc(addTrackWishlistDatObject:)
    @NSManaged public func addToTrackWishlistDat(_ value: Track)

    @objc(removeTrackWishlistDatObject:)
    @NSManaged public func removeFromTrackWishlistDat(_ value: Track)

    @objc(addTrackWishlistDat:)
    @NSManaged public func addToTrackWishlistDat(_ values: NSSet)

    @objc(removeTrackWishlistDat:)
    @NSManaged public func removeFromTrackWishlistDat(_ values: NSSet)

}

// MARK: Generated accessors for tripsDat
extension User {

    @objc(addTripsDatObject:)
    @NSManaged public func addToTripsDat(_ value: Trip)

    @objc(removeTripsDatObject:)
    @NSManaged public func removeFromTripsDat(_ value: Trip)

    @objc(addTripsDat:)
    @NSManaged public func addToTripsDat(_ values: NSSet)

    @objc(removeTripsDat:)
    @NSManaged public func removeFromTripsDat(_ values: NSSet)

}

extension User : Identifiable {

}
