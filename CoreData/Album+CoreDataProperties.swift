//
//  Album+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/24/23.
//
//

import Foundation
import CoreData


extension Album {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }

    @NSManaged public var artistsDat: [NSString]?
    @NSManaged public var costDat: Double
    @NSManaged public var genreDat: String?
    @NSManaged public var isCollectionDat: Bool
    @NSManaged public var isCompilationDat: Bool
    @NSManaged public var isGHDat: Bool
    @NSManaged public var isLiveDat: Bool
    @NSManaged public var isMixDat: Bool
    @NSManaged public var labelDat: String?
    @NSManaged public var releaseYearDat: Int64
    @NSManaged public var titleDat: String?
    @NSManaged public var uniquenessDat: Int64
    @NSManaged public var valueDat: Double
    @NSManaged public var catalogDat: Catalog?
    @NSManaged public var storeDat: Store?
    @NSManaged public var userWishlistDat: User?
    @NSManaged public var recordsDat: NSSet?
    @NSManaged public var stopNewAlbumsDat: Store?
    @NSManaged public var stopSoldAlbumsDat: Store?
    
    public var isCompilation: Bool {
        isCompilationDat ?? false
    }
    
    public var isMix: Bool {
        isMixDat ?? false
    }
    
    public var isGH: Bool {
        isGHDat ?? false
    }
    
    public var isCollection: Bool {
        isCollectionDat ?? false
    }
    
    public var isLive: Bool {
        isLiveDat ?? false
    }
    
    public var genre: String {
        genreDat ?? ""
    }
    
    public var releaseYear: Int? {
        if releaseYearDat != nil {
            return Int(truncatingIfNeeded: releaseYearDat)
        } else {
            return nil
        }
    }
    
    public var title: String {
        titleDat ?? ""
    }
    
    public var label: String {
        labelDat ?? ""
    }
    
    public var artists: [String] {
        artistsDat as? [String] ?? []
    }
    
    public var value: Double {
        valueDat ?? 0
    }
    
    public var cost: Double {
        costDat ?? 0
    }
    
    public var uniqueness: UniqueTracks.Uniqueness {
        let num64 = uniquenessDat ?? 4
        let num = Int(truncatingIfNeeded: num64)
        return UniqueTracks.Uniqueness(rawValue: num) ?? UniqueTracks.Uniqueness.unique
    }
    
    public var store: Store? {
        storeDat
    }
    
    public var records: [Record] {
        let recordSet = recordsDat as? Set<Record> ?? []
        
        return recordSet.sorted {
            $0.title < $1.title
        }
    }

}

// MARK: Generated accessors for recordsDat
extension Album {

    @objc(addRecordsDatObject:)
    @NSManaged public func addToRecordsDat(_ value: Record)

    @objc(removeRecordsDatObject:)
    @NSManaged public func removeFromRecordsDat(_ value: Record)

    @objc(addRecordsDat:)
    @NSManaged public func addToRecordsDat(_ values: NSSet)

    @objc(removeRecordsDat:)
    @NSManaged public func removeFromRecordsDat(_ values: NSSet)

}

extension Album : Identifiable {

}
