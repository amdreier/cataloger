//
//  Catalog+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/24/23.
//
//

import Foundation
import CoreData


extension Catalog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Catalog> {
        return NSFetchRequest<Catalog>(entityName: "Catalog")
    }

    @NSManaged public var allAlbumsDat: NSSet?
    @NSManaged public var uniqueTracksDat: UniqueTracks?
    @NSManaged public var userDat: User?
    
    
    
    public var uniqueTracks: UniqueTracks {
        uniqueTracksDat ?? UniqueTracks()
    }
}

// MARK: Generated accessors for allAlbumsDat
extension Catalog {

    @objc(addAllAlbumsDatObject:)
    @NSManaged public func addToAllAlbumsDat(_ value: Album)

    @objc(removeAllAlbumsDatObject:)
    @NSManaged public func removeFromAllAlbumsDat(_ value: Album)

    @objc(addAllAlbumsDat:)
    @NSManaged public func addToAllAlbumsDat(_ values: NSSet)

    @objc(removeAllAlbumsDat:)
    @NSManaged public func removeFromAllAlbumsDat(_ values: NSSet)

}

extension Catalog : Identifiable {

}
