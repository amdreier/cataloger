//
//  Cataloge.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/13/23.
//

import Foundation

/// - TODO: Add and remove records from albums

struct Catalog {
    var allAlbums = [Album]()
    var uniqueTracks = UniqueTracks()
    
    func getNumRecords() -> Int {
        var count: Int = 0
        for album in allAlbums {
            count += album.records.count
        }
        
        return count
    }
    
    mutating func addAlbum(album: Album) -> UniqueTracks.Uniqueness {
        allAlbums.append(album)
        var uniqueness = UniqueTracks.Uniqueness.version
        for track in album.getTracks() {
            let trackUniqueness = uniqueTracks.addTrack(track: track)
            
            if (trackUniqueness > uniqueness) {
                uniqueness = trackUniqueness
            }
        }
        
        return uniqueness
    }
    
    mutating func removeAlbum(album: Album) -> Bool {
        let index = allAlbums.firstIndex(of: album)
        if index != nil {
            allAlbums.remove(at: index!)
            for track in album.getTracks() {
                let _ = uniqueTracks.removeTrack(track: track)
            }
            return true
        } else {
            return false
        }
    }
    
    mutating func addRecord(record: Record, album: Album) -> Bool {
        let index = allAlbums.firstIndex(of: album)
        if index != nil {
            allAlbums[index!].addRecord(record)
            return true
        } else {
            return false
        }
    }
    
    func getAllTracks() -> [Track] {
        var tracks = [Track]()
        for album in allAlbums {
            tracks.append(contentsOf: album.getTracks())
        }
        
        return tracks
    }
    
    func getAllRecords() -> [Record] {
        var records = [Record]()
        for album in allAlbums {
            records.append(contentsOf: album.records)
        }
        
        return records
    }
    
    func contains(_ album: Album) -> Bool {
        allAlbums.contains(album)
    }
    
    func contains(_ record: Record) -> Bool {
        getAllRecords().contains(record)
    }
    
    func contains(_ track: Track) -> Bool {
        getAllTracks().contains(track)
    }
}
