//
//  Album.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/8/23.
//

import Foundation
import CoreData

@objc(Album)
class Album: NSManagedObject {
    static func ==(lhs: Album, rhs: Album) -> Bool {
        lhs.isCompilation == rhs.isCompilation && lhs.isMix == rhs.isMix && lhs.isGH == rhs.isGH && lhs.isCollection == rhs.isCollection && lhs.isLive == rhs.isLive && lhs.genre == rhs.genre && lhs.releaseYear == rhs.releaseYear && lhs.title == rhs.title && lhs.label == rhs.label && lhs.artists == rhs.artists && lhs.value == rhs.value && lhs.cost == rhs.cost && lhs.uniqueness == rhs.uniqueness && lhs.store == rhs.store && lhs.records == rhs.records
    }
    
//    var isCompilation: Bool = false                 // songs not originally released together
//    var isMix: Bool = false                         // different artists
//    var isGH: Bool = false                          // greatest hits
//    var isCollection: Bool = false                  // box set, etc
//    var isLive: Bool = false                        // is this is a live recording
//    var genre: String = ""                       // from standard list
//    var releaseYear: Int?                   // release year
//    var title: String = ""                       // Album title
//    var label: String = ""                       // release label company
//    var artists = [String]()                // all artists/band names, LastName, FirstName MiddleNames/BandName, The
//    var value: Double = 0                       // resale price USD
//    var cost: Double = 0                       // paid price USD
//    var uniqueness: UniqueTracks.Uniqueness = UniqueTracks.Uniqueness.unique // the uniquenss of the most unique record in the album
//    var store: Store?                       // where it was bought
    
//    var records = [Record]()
    
    init(context: NSManagedObjectContext, isCompilation: Bool = false, isMix: Bool = false, isGH: Bool = false, isCollection: Bool = false, isLive: Bool = false, genre: String = "N/A", releaseYear: Int? = nil, title: String = "N/A", label: String = "N/A", artists: [String] = [String](), value: Double = 0, cost: Double = 0, uniqueness: UniqueTracks.Uniqueness = UniqueTracks.Uniqueness.unique, store: Store? = nil, records: [Record] = [Record]()) {
        super.init(entity: NSEntityDescription.entity(forEntityName: "Album", in: context)!, insertInto: context)
        
        self.isCompilationDat = isCompilation
        self.isMixDat = isMix
        self.isGHDat = isGH
        self.isCollectionDat = isCollection
        self.isLiveDat = isLive
        self.genreDat = genre
        self.releaseYearDat = releaseYear == nil ? -1 : Int64(releaseYear!)
        self.titleDat = title
        self.labelDat = label
        self.artistsDat = artists as [NSString]
        self.valueDat = value
        self.costDat = cost
        self.uniquenessDat = Int64(uniqueness.rawValue)
        self.storeDat = store
        self.recordsDat = NSSet(array: records)
    }
    
    func updateUniqueness(newUniqueness: UniqueTracks.Uniqueness) {
        if newUniqueness > self.uniqueness {
            self.uniquenessDat = Int64(newUniqueness.rawValue)
        }
    }
    
    func addRecord(_ record: Record) {
        addToRecordsDat(record)
        let _ = recheckUniqueness()
    }
    
    func recheckUniqueness() -> UniqueTracks.Uniqueness {
        self.uniquenessDat = Int64(UniqueTracks.Uniqueness.version.rawValue)
        for record in records {
            self.updateUniqueness(newUniqueness: record.uniqueness)
        }
        
        return self.uniqueness
    }
    
    
    /// - Description: Gets all the Tracks on an album
    /// - Returns: An array of all Tracks on the album
    func getTracks() -> [Track] {
        var tracks = [Track]()
        for record in records {
            tracks.append(contentsOf: record.tracks)
        }
        
        return tracks
    }
    
    /// - Description: Helper function counts the number of records in an array of albums
    /// - Parameter albums: Array of albums
    /// - Returns: Number of records in all of the albums
    static func recordCount(_ albums: [Album]) -> Int {
        var count: Int = 0
        for album in albums {
            count += album.records.count
        }
        
        return count
    }
}


