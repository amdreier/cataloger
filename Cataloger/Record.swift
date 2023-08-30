//
//  Record.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/8/23.
//

import Foundation
import CoreData

@objc(Record)
class Record: NSManagedObject {
//    @Published var isCompilation: Bool = false                 // songs not originally released together
//    @Published var isMix: Bool = false                        // different artists
//    @Published var isGH: Bool = false                         // greatest hits
//    @Published var isCollection: Bool = false                  // box set, etc
//    @Published var isLive: Bool = false                        // is this a live recording
//    @Published var genre: String = ""                       // from standard list
//    @Published var releaseYear: Int?                   // release year
//    @Published var title: String = ""                       // record title
//    @Published var label: String = ""                       // release label company
//    @Published var artists = [String]()                // all artists/band names, LastName, FirstName MiddleNames/BandName, The
//    @Published var speed: Int = 33                          // 33, 45, or 78
//    @Published var value: Double = 0                       // resale price USD
//    @Published var cost: Double = 0                        // paid price USD
//    @Published var uniqueness: UniqueTracks.Uniqueness = UniqueTracks.Uniqueness.unique // unqiueness of this record
//    @Published var album: Album?                       // album for this record on this catelogue
//    @Published var store: Store?                       // where it was bought
    
//    @Published var trackManualMode: Bool = false
    
//    @Published var tracks = [Track]()                  // list of all songs on the record
    
    init(context: NSManagedObjectContext, isCompilation: Bool = false, isMix: Bool = false, isGH: Bool = false, isCollection: Bool = false, isLive: Bool = false, genre: String = "", releaseYear: Int? = nil, title: String = "", label: String = "", artists: [String] = [String](), speed: Int = 33, value: Double = 0, cost: Double = 0, uniqueness: UniqueTracks.Uniqueness = UniqueTracks.Uniqueness.unique, album: Album? = nil, store: Store? = nil, tracks: [Track] = [Track]()) {
        super.init(entity: NSEntityDescription.entity(forEntityName: "Record", in: context)!, insertInto: context)
        
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
        self.speedDat = Int64(speed)
        self.valueDat = value
        self.costDat = cost
        self.uniquenessDat = Int64(uniqueness.rawValue)
        self.albumDat = album
        self.storeDat = store
        self.tracksDat = NSSet(array: tracks)
    }
    
    func removeTrack(_ track: Track) -> Bool {
        removeFromTracksDat(track)
        
        return tracks.contains(track)
    }
    
    func recheckUniqueness() -> UniqueTracks.Uniqueness {
        self.uniquenessDat = Int64(UniqueTracks.Uniqueness.version.rawValue)
        for track in tracks {
            self.updateUniqueness(newUniqueness: track.uniqueness)
        }
        
        let _ = self.album?.recheckUniqueness()
        return self.uniqueness
    }
    
    func updateUniqueness(newUniqueness: UniqueTracks.Uniqueness) {
        if newUniqueness > self.uniqueness {
            self.uniquenessDat = Int64(newUniqueness.rawValue)
            album?.updateUniqueness(newUniqueness: newUniqueness)
        }
    }
    
    static func ==(lhs: Record, rhs: Record) -> Bool {
        lhs.title == rhs.title && lhs.label == rhs.label && lhs.releaseYear == rhs.releaseYear && lhs.tracks == rhs.tracks
    }
}
