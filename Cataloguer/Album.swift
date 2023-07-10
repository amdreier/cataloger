//
//  Album.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/8/23.
//

import Foundation

struct Album {
    var isCompilation: Bool     // songs not originally released together
    var isMix: Bool             // different artists
    var isGH: Bool              // greatest hits
    var isCollection: Bool      // box set, etc
    var genre: String           // from standard list
    var releaseYear: Int        // release year
    var title: String           // Album title
    var label: String           // release label company
    var artists = [String]()    // all artists/band names, LastName, FirstName MiddleNames/BandName, The
    var value: Double           // resale price USD
    var cost: Double            // paid price USD
    var store: Store?            // where it was bought
    
    var records = [Record]()
    
    init(isCompilation: Bool, isMix: Bool, isGH: Bool, isCollection: Bool, genre: String, releaseYear: Int, title: String, label: String, artists: [String] = [String](), value: Double, cost: Double, store: Store? = nil, records: [Record] = [Record]()) {
        self.isCompilation = isCompilation
        self.isMix = isMix
        self.isGH = isGH
        self.isCollection = isCollection
        self.genre = genre
        self.releaseYear = releaseYear
        self.title = title
        self.label = label
        self.artists = artists
        self.value = value
        self.cost = cost
        self.store = store
        self.records = records
    }
}
