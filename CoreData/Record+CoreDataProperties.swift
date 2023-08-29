//
//  Record+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/24/23.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var isCompilationDat: Bool
    @NSManaged public var isMixDat: Bool
    @NSManaged public var isGHDat: Bool
    @NSManaged public var isCollectionDat: Bool
    @NSManaged public var isLiveDat: Bool
    @NSManaged public var genreDat: String?
    @NSManaged public var releaseYearDat: Int64
    @NSManaged public var titleDat: String?
    @NSManaged public var labelDat: String?
    @NSManaged public var artistsDat: [String]?
    @NSManaged public var speedDat: Int64
    @NSManaged public var valueDat: Double
    @NSManaged public var costDat: Double
    @NSManaged public var uniquenessDat: Int64
    @NSManaged public var albumDat: Album?
    @NSManaged public var storeDat: Store?
    @NSManaged public var tracksDat: NSSet?
    @NSManaged public var isManualModeDat: Bool
    
    public var isManualMode: Bool {
        isManualModeDat ?? false
    }
    
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
        artistsDat ?? []
    }
    
    public var speed: Int {
        if speedDat != nil {
            return Int(truncatingIfNeeded: speedDat)
        } else {
            return 33
        }
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
    
    public var album: Album? {
        albumDat ?? nil
    }
    
    public var store: Store? {
        storeDat ?? nil
    }
    
    public var tracks: [Track] {
        let trackSet = tracksDat as? Set<Track> ?? []
        
        return trackSet.sorted {
            $0.title < $1.title
        }
    }

}

// MARK: Generated accessors for tracksDat
extension Record {

    @objc(addTracksDatObject:)
    @NSManaged public func addToTracksDat(_ value: Track)

    @objc(removeTracksDatObject:)
    @NSManaged public func removeFromTracksDat(_ value: Track)

    @objc(addTracksDat:)
    @NSManaged public func addToTracksDat(_ values: NSSet)

    @objc(removeTracksDat:)
    @NSManaged public func removeFromTracksDat(_ values: NSSet)

}

extension Record : Identifiable {

}
