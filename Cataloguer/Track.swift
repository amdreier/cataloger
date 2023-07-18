//
//  Track.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/10/23.
//

import Foundation

class Track: Hashable {
    static func ==(lhs: Track, rhs: Track) -> Bool {
        lhs.title == rhs.title && lhs.artists == rhs.artists && lhs.releaseYear == rhs.releaseYear && lhs.genre == rhs.genre && lhs.isLive == rhs.isLive && lhs.uniqueness == rhs.uniqueness && lhs.record == rhs.record
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    var title: String                       // track/song title
    var artists = [String]()                // all artists/band names, LastName, FirstName MiddleNames/BandName, The
    var releaseYear: Int                    // original release year of track
    var genre: String                       // from standard list
    var isLive: Bool                        // is this track from a live recording
    var uniqueness: UniqueTracks.Uniqueness // uniqueness of the most unique track on the record
    var record: Record?                     // record this track is on
    
    init(title: String, artists: [String] = [String](), releaseYear: Int, genre: String, isLive: Bool, uniqueness: UniqueTracks.Uniqueness = UniqueTracks.Uniqueness.unique, record: Record? = nil) {
        self.title = title
        self.artists = artists
        self.releaseYear = releaseYear
        self.genre = genre
        self.isLive = isLive
        self.uniqueness = uniqueness
        self.record = record
    }
    
    static func artistsStr(artists: [String]) -> String {
        var output: String = ""
        for artist in artists {
            output.append(contentsOf: ", ")
            output.append(contentsOf: artist)
        }
        
        if output.count >= 2 {
            output.remove(at: output.endIndex)
            output.remove(at: output.endIndex)
        }
        
        return output
    }
    
    func updateUniqueness(newUniqueness: UniqueTracks.Uniqueness) {
        if newUniqueness > self.uniqueness {
            self.uniqueness = newUniqueness
            record?.updateUniqueness(newUniqueness: newUniqueness)
        }
    }
}
