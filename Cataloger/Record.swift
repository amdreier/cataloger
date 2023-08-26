//
//  Record.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/8/23.
//

import Foundation
import CoreData

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
    
    @Published var trackManualMode: Bool = false
    
//    @Published var tracks = [Track]()                  // list of all songs on the record
    
    init(isCompilation: Bool = false, isMix: Bool = false, isGH: Bool = false, isCollection: Bool = false, isLive: Bool = false, genre: String = "", releaseYear: Int? = nil, title: String = "", label: String = "", artists: [String] = [String](), speed: Int = 33, value: Double = 0, cost: Double = 0, uniqueness: UniqueTracks.Uniqueness = UniqueTracks.Uniqueness.unique, album: Album? = nil, store: Store? = nil, tracks: [Track] = [Track]()) {
        super.init()
        
        self.isCompilation = isCompilation
        self.isMix = isMix
        self.isGH = isGH
        self.isCollection = isCollection
        self.isLive = isLive
        self.genre = genre
        self.releaseYear = releaseYear
        self.title = title
        self.label = label
        self.artists = artists
        self.speed = speed
        self.value = value
        self.cost = cost
        self.uniqueness = uniqueness
        self.album = album
        self.store = store
        self.tracks = tracks
    }
    
    func removeTrack(_ track: Track) -> Bool {
        let index = tracks.firstIndex(of: track)
        if index != nil {
            tracks.remove(at: index!)
            let _ = self.recheckUniqueness()
            return true
        } else {
            return false
        }
    }
    
    func recheckUniqueness() -> UniqueTracks.Uniqueness {
        self.uniqueness = UniqueTracks.Uniqueness.version
        for track in tracks {
            self.updateUniqueness(newUniqueness: track.uniqueness)
        }
        
        let _ = self.album?.recheckUniqueness()
        return self.uniqueness
    }
    
    func updateUniqueness(newUniqueness: UniqueTracks.Uniqueness) {
        if newUniqueness > self.uniqueness {
            self.uniqueness = newUniqueness
            album?.updateUniqueness(newUniqueness: newUniqueness)
        }
    }
    
    static func ==(lhs: Record, rhs: Record) -> Bool {
        lhs.title == rhs.title && lhs.label == rhs.label && lhs.releaseYear == rhs.releaseYear && lhs.tracks == rhs.tracks
    }
}
