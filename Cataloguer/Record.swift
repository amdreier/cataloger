//
//  Record.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/8/23.
//

import Foundation

struct Record {
    var isCompilation: Bool     // songs not originally released together
    var isMix: Bool             // different artists
    var isGH: Bool              // greatest hits
    var isCollection: Bool      // box set, etc
    var genre: String           // from standard list
    var releaseYear: Int        // release year
    var title: String           // record title
    var label: String           // release label company
    var artists = [String]()    // all artists/band names, LastName, FirstName MiddleNames/BandName, The
    var speed: Int              // 33, 45, or 78
    var value: Double           // resale price USD
    var cost: Double            // paid price USD
    var store: Store?            // where it was bought
    
    var tracks = [Track]()      // list of all songs on the record
    
    init(isCompilation: Bool, isMix: Bool, isGH: Bool, isCollection: Bool, genre: String, releaseYear: Int, title: String, label: String, artists: [String] = [String](), speed: Int, value: Double, cost: Double, store: Store? = nil, tracks: [Track] = [Track]()) {
        self.isCompilation = isCompilation
        self.isMix = isMix
        self.isGH = isGH
        self.isCollection = isCollection
        self.genre = genre
        self.releaseYear = releaseYear
        self.title = title
        self.label = label
        self.artists = artists
        self.speed = speed
        self.value = value
        self.cost = cost
        self.store = store
        self.tracks = tracks
    }
}
