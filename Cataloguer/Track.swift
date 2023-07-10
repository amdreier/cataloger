//
//  Track.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/10/23.
//

import Foundation

struct Track {
    var title: String           // track/song title
    var artists = [String]()    // all artists/band names, LastName, FirstName MiddleNames/BandName, The
    var releaseYear: Int        // original release year of track
    var genre: String           // from standard list
    
    init(title: String, artists: [String] = [String](), releaseYear: Int, genre: String) {
        self.title = title
        self.artists = artists
        self.releaseYear = releaseYear
        self.genre = genre
    }
}
