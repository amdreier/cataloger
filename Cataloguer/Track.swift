//
//  Track.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/10/23.
//

import Foundation

struct Track: Hashable {
    var title: String           // track/song title
    var artists = [String]()    // all artists/band names, LastName, FirstName MiddleNames/BandName, The
    var releaseYear: Int        // original release year of track
    var genre: String           // from standard list
    var isLive: Bool            // is this track from a live recording
    var record: Record?         // record this track is on
    
    init(title: String, artists: [String] = [String](), releaseYear: Int, genre: String, isLive: Bool, record: Record? = nil) {
        self.title = title
        self.artists = artists
        self.releaseYear = releaseYear
        self.genre = genre
        self.isLive = isLive
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
}
