//
//  Record.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/8/23.
//

import Foundation

class Record: Equatable, Hashable {
    var isCompilation: Bool                 // songs not originally released together
    var isMix: Bool                         // different artists
    var isGH: Bool                          // greatest hits
    var isCollection: Bool                  // box set, etc
    var isLive: Bool                        // is this a live recording
    var genre: String                       // from standard list
    var releaseYear: Int                    // release year
    var title: String                       // record title
    var label: String                       // release label company
    var artists = [String]()                // all artists/band names, LastName, FirstName MiddleNames/BandName, The
    var speed: Int                          // 33, 45, or 78
    var value: Double                       // resale price USD
    var cost: Double                        // paid price USD
    var uniqueness: UniqueTracks.Uniqueness // unqiueness of this record
    var album: Album                        // album for this record on this catelogue
    var store: Store?                       // where it was bought
    
    var tracks = [Track]()                  // list of all songs on the record
    
    /// All Tracks with this filter NOT in NoFilter AND NOT in SameArtist
    var uniqueTracksSameVersion = Set<Track>()
    /// All Tracks with this filter NOT in NoFilter
    var uniqueTracksSameArtists = Set<Track>()
    /// All Tracks with this filter
    var uniqueTracksNoFilter = Set<Track>()
    
    init(isCompilation: Bool, isMix: Bool, isGH: Bool, isCollection: Bool, isLive: Bool, genre: String, releaseYear: Int, title: String, label: String, artists: [String] = [String](), speed: Int, value: Double, cost: Double, uniqueness: UniqueTracks.Uniqueness = UniqueTracks.Uniqueness.unique, album: Album, store: Store? = nil, tracks: [Track] = [Track]()) {
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    func updateUniqueness(newUniqueness: UniqueTracks.Uniqueness) {
        if newUniqueness > self.uniqueness {
            self.uniqueness = newUniqueness
            album.updateUniqueness(newUniqueness: newUniqueness)
        }
    }
    
    static func ==(lhs: Record, rhs: Record) -> Bool {
        lhs.title == rhs.title && lhs.label == rhs.label && lhs.releaseYear == rhs.releaseYear && lhs.tracks == rhs.tracks
    }
}
