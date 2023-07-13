//
//  Catalogue.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/13/23.
//

import Foundation

struct Catalogue {
    var allAlbums = [Album]()
    var uniqueTracks = UniqueTracks()
    
    func getAllTracks() -> [Track] {
        var tracks = [Track]()
        for album in allAlbums {
            tracks.append(contentsOf: album.getTracks())
        }
        
        return tracks
    }
}
