//
//  UniqueTracks.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/13/23.
//

import Foundation

// Need to deel with no filter case of same track name but different song, user manual verification?
/* Unique Tracks Filtering
 * Filters:
 *  - Title (No filter)
 *  - Artists
 *  - Version (Year + Live)
*/
struct UniqueTracks {
    /* Dictionary Key data structures */
    enum TrackTitle: Equatable, Hashable {
        case title(_ title: String)
    }
    enum TrackTitleAndArtists: Equatable, Hashable {
        case titleAndArtist(title: String, artists: [String])
    }
    enum TrackVersion: Equatable, Hashable {
        case version(title: String, artists: [String], releaseYear: Int, isLive: Bool)
    }
    
    /* Uniqueness data structure */
    enum Uniqueness {
        /// No track has the same title, artist, or version
        case unique
        /// No track has the same artist or version, but there is at least one with the same title
        case title
        /// No track has the same version, but there is at least one with the same title and artist
        case artist
        /// There is at least one other track with the same title, artist, and version
        case version
    }
    
    enum NewUnique {
        case newUnique(unique: [Track], title: [Track], artist: [Track])
    }
    
    /*
     *  Logically ordered A⊆B⊆C
     *  To conserve memory, this is actually storing A, then B - A, then (C - A) - B
     *  A = A, B = A + (B - A), C = A + B + (C - A) - B
     *
     *  Examples:
     *      - If a Track is unique by the same version filter, it doesn't need to be stored as unique by the
     *        same artist filter, as this is implied
     *      - If a Track is a duplicate by the same artist filter, it'll still be a duplicate with no filter
     */
    /* Unique Tracks */
    /// All Tracks with this filter NOT in NoFilter AND NOT in SameArtist
    var uniqueTracksSameVersion: [TrackVersion: Track] = [:]
    /// All Tracks with this filter NOT in NoFilter
    var uniqueTracksSameArtists: [TrackTitleAndArtists: Track] = [:]
    /// All Tracks with this filter
    var uniqueTracksNoFilter: [TrackTitle: Track] = [:]
    
    /* Duplicate Tracks (Dict Track string info name ) */
    /// All Tracks makred Duplicate matching all criteria
    var duplicateTracksSameVersion: [TrackVersion: [Track]] = [:]
    /// All Tracks marked Duplicate,  Artist but not version
    var duplicateTracksSameArtists: [TrackTitleAndArtists: [Track]] = [:]
    /// All Tracks marked Duplicate, just same version, but not same
    var duplicateTracksNoFilter: [TrackTitle: [Track]] = [:]
    
    /// <#Description#>
    /// - Parameter track: <#track description#>
    /// - Returns: <#description#>
    mutating func addTrack(track: Track) -> Uniqueness {
        var uniqueness: Uniqueness = Uniqueness.unique
        
        let noFilter: Track? = uniqueTracksNoFilter[TrackTitle.title(track.title)]
        let artists: Track? = uniqueTracksSameArtists[TrackTitleAndArtists.titleAndArtist(title: track.title, artists: track.artists)]
        let version: Track? = uniqueTracksSameVersion[TrackVersion.version(title: track.title, artists: track.artists, releaseYear: track.releaseYear, isLive: track.isLive)]
        
        
        /// = TODO: RECHECK LOGIC!!!! Then, add in actual functionality of adding to and removing from the correct sets, finish docs
        if version == nil {
            uniqueness = Uniqueness.artist
        } else {
            uniqueness = Uniqueness.version
            return uniqueness
        }
        
        if artists == nil {
            uniqueness = Uniqueness.title
        } else {
            return uniqueness
        }
        
        if noFilter == nil {
            uniqueness = Uniqueness.unique
        } else {
            return uniqueness
        }
        
        return uniqueness
    }
    
    /// - TODO: implement and finish dos
    /// <#Description#>
    /// - Parameter track: <#track description#>
    /// - Returns: <#description#>
    mutating func removeTrack(track: Track) -> NewUnique? {
        return nil
    }
}
