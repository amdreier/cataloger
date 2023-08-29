//
//  Track.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/10/23.
//

import Foundation
import CoreData

class Track: NSManagedObject {
    static func ==(lhs: Track, rhs: Track) -> Bool {
        lhs.title == rhs.title && lhs.artists == rhs.artists && lhs.releaseYear == rhs.releaseYear && lhs.genre == rhs.genre && lhs.isLive == rhs.isLive && lhs.uniqueness == rhs.uniqueness && lhs.record == rhs.record
    }
    
//    var title: String = ""                       // track/song title
//    var artists = [String]()                // all artists/band names, LastName, FirstName MiddleNames/BandName, The
//    var releaseYear: Int?                   // original release year of track
//    var genre: String = ""                       // from standard list
//    var isLive: Bool = false                        // is this track from a live recording
//    var uniqueness: UniqueTracks.Uniqueness = UniqueTracks.Uniqueness.unique // uniqueness of the most unique track on the record
//    var record: Record?                     // record this track is on
    
    init(context: NSManagedObjectContext, title: String, artists: [String] = [String](), releaseYear: Int? = nil, genre: String = "", isLive: Bool = false, uniqueness: UniqueTracks.Uniqueness = UniqueTracks.Uniqueness.unique, record: Record? = nil) {
        super.init(entity: NSEntityDescription(), insertInto: context)
        
        self.titleDat = title
        self.artistsDat = artists
        self.releaseYearDat = releaseYear == nil ? -1 : Int64(releaseYear!)
        self.genreDat = genre
        self.isLiveDat = isLive
        self.uniquenessDat = Int64(uniqueness.rawValue)
        self.recordDat = record
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
            self.uniquenessDat = Int64(newUniqueness.rawValue)
            record?.updateUniqueness(newUniqueness: newUniqueness)
        }
    }
}
