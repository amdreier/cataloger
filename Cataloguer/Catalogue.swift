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
    
    mutating func addAlbum(album: inout Album) -> UniqueTracks.Uniqueness {
        allAlbums.append(album)
        var uniqueness = UniqueTracks.Uniqueness.version
        for track in album.getTracks() {
            let trackUniqueness = uniqueTracks.addTrack(track: track)
            
            if (trackUniqueness > uniqueness) {
                uniqueness = trackUniqueness
            }
        }
        
        album.uniqueness = uniqueness
        return uniqueness
    }
    
    func getAllTracks() -> [Track] {
        var tracks = [Track]()
        for album in allAlbums {
            tracks.append(contentsOf: album.getTracks())
        }
        
        return tracks
    }
}
