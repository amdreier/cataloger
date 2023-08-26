//
//  UniqueTracks.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/13/23.
//

import Foundation
import CoreData

// Need to deel with no filter case of same track name but different song, user manual verification?
/* Unique Tracks Filtering
 * Filters:
 *  - Title (No filter)
 *  - Artists
 *  - Version (Year + Live)
*/
class UniqueTracks: NSManagedObject {
    /* Dictionary Key data structures */
    class TrackTitle: NSManagedObject {
        var title: String = ""
        
        init(_ title: String) {
            self.title = title
        }
    }
    class TrackTitleAndArtists: NSManagedObject {
        var title: String = ""
        var artists: [String] = []
        
        init(title: String, artists: [String]) {
            self.title = title
            self.artists = artists
        }
    }
    class TrackVersion: NSManagedObject {
        var title: String = ""
        var artists: [String] = []
        var releaseYear: Int? = nil
        var isLive: Bool = false
        
        init(title: String, artists: [String], releaseYear: Int? = nil, isLive: Bool) {
            self.title = title
            self.artists = artists
            self.releaseYear = releaseYear
            self.isLive = isLive
        }
    }
    
    /* Uniqueness data structure */
    enum Uniqueness: Int, Comparable {
        /// No track has the same title, artist, or version
        case unique = 3
        /// No track has the same artist or version, but there is at least one with the same title
        case title = 2
        /// No track has the same version, but there is at least one with the same title and artist
        case artist = 1
        /// There is at least one other track with the same title, artist, and version
        case version = 0
        
        static func <(lhs: Uniqueness, rhs: Uniqueness) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
    
    enum NewUnique {
        case none
        case newUnique(track: Track, uniqueness: Uniqueness)
    }
    
    
    var tracksByTitle: [TrackTitle: [Track]] = [:]
    var tracksByArtist: [TrackTitleAndArtists: [Track]] = [:]
    var tracksByVersion: [TrackVersion: [Track]] = [:]
    
    /*
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
    /// All Tracks with this filter (nothing with same title)
    var uniqueTracksNoFilter: [TrackTitle: Track] = [:]
    /// All Tracks with this filter NOT in NoFilter (nothing with same artist, but same name)
    var uniqueTracksSameArtists: [TrackTitleAndArtists: Track] = [:]
    /// All Tracks with this filter NOT in NoFilter AND NOT in SameArtist (nothing with same version, but same artist and title)
    var uniqueTracksSameVersion: [TrackVersion: Track] = [:]
    
    /* Duplicate Tracks (Dict Track string info name ) */
    /// All Tracks makred Duplicate matching all criteria
    var duplicateTracksSameVersion: [TrackVersion: [Track]] = [:]
    /// All Tracks marked Duplicate,  by same Artist but not same version
    var duplicateTracksSameArtists: [TrackTitleAndArtists: [Track]] = [:]
    /// All Tracks marked Duplicate, just same title, but not same artist or version
    var duplicateTracksNoFilter: [TrackTitle: [Track]] = [:]
    
    */
    /// - Description: Adds a track to the uniqueness tracker of all tracks and updates the corresponding records
    /// - Parameter track: The track to be added to the uniqueness tracker
    /// - Returns: The Uniqueness of the track for this Catelogue
    func addTrack(track: Track) -> Uniqueness {
        let trkTtl = TrackTitle(track.title)
        let trkArtsTtl = TrackTitleAndArtists(title: track.title, artists: track.artists)
        let trkVrsn = TrackVersion(title: track.title, artists: track.artists, releaseYear: track.releaseYear, isLive: track.isLive)
        var uniqueness = Uniqueness.unique
        
        var byTitle = tracksByTitle[trkTtl]
        var byArtist = tracksByArtist[trkArtsTtl]
        var byVersion = tracksByVersion[trkVrsn]
        
        if byTitle != nil {
            uniqueness = Uniqueness.title
            if (byTitle?.count == 1) {
                byTitle?[0].updateUniqueness(newUniqueness: uniqueness)
            }
            
            byTitle?.append(track)
        } else {
            tracksByTitle[trkTtl] = [track]
        }
        
        if byArtist != nil {
            uniqueness = Uniqueness.artist
            if (byArtist?.count == 1) {
                byArtist?[0].updateUniqueness(newUniqueness: uniqueness)
            }
            
            byArtist?.append(track)
        } else {
            tracksByArtist[trkArtsTtl] = [track]
        }
        
        if byVersion != nil {
            uniqueness = Uniqueness.version
            if (byVersion?.count == 1) {
                byVersion?[0].updateUniqueness(newUniqueness: uniqueness)
            }
            
            byVersion?.append(track)
        } else {
            tracksByVersion[trkVrsn] = [track]
        }
        
        track.updateUniqueness(newUniqueness: uniqueness)
        return uniqueness
        /*
        var noFilter: Track? = uniqueTracksNoFilter[trkTtl]
        var artists: Track? = uniqueTracksSameArtists[trkArtsTtl]
        var version: Track? = uniqueTracksSameVersion[trkVrsn]
        
        var noFilterDupe: [Track]? = duplicateTracksNoFilter[trkTtl]
        var artistsDupe: [Track]? = duplicateTracksSameArtists[trkArtsTtl]
        var versionDupe: [Track]? = duplicateTracksSameVersion[trkVrsn]
        
        /*
         * Easiest to distinguish by uniqueness, checking all ways it could be each uniqueness, and acting acordingly
         * Checking in the order allows the track to be added to the correct list, as if there's a match, there's a lower bound on uniqueness
         */
        
        if versionDupe != nil {
            versionDupe?.append(track)
            return Uniqueness.version
        }
        
        if version != nil {
            let value = uniqueTracksSameVersion.removeValue(forKey: trkVrsn)
            duplicateTracksSameVersion[trkVrsn] = [track, value!]
            track.record?.uniqueTracksSameVersion.remove(track)
            return Uniqueness.version
        }
        
        if artistsDupe != nil {
            artistsDupe?.append(track)
            return Uniqueness.artist
        }
        
        if artists != nil {
            let value = uniqueTracksSameArtists.removeValue(forKey: trkArtsTtl)
            duplicateTracksSameArtists[trkArtsTtl] = [track, value!]
            uniqueTracksSameVersion[trkVrsn] = track
            return Uniqueness.artist
        }
        
        
        if noFilter != nil {
            
        }
        
        if noFilterDupe != nil {
            
        }
        
        
        uniqueTracksNoFilter[trkTtl] = track
         
        
        return Uniqueness.unique
        */
    }
    
    /// - Description: Removes a track from the filters
    /// - Parameter track: Track to remove from filter
    /// - Returns: A 3-tuple of tracks which have new uniqueness values, each slot for  the uniqueness they got, or nil if the track doesn't exist
    func removeTrack(track: Track) -> NewUnique? {
        let trkTtl = TrackTitle(track.title)
        let trkArtsTtl = TrackTitleAndArtists(title: track.title, artists: track.artists)
        let trkVrsn = TrackVersion(title: track.title, artists: track.artists, releaseYear: track.releaseYear, isLive: track.isLive)
        
        var byTitle = tracksByTitle[trkTtl]
        var byArtist = tracksByArtist[trkArtsTtl]
        var byVersion = tracksByVersion[trkVrsn]
        
        if byTitle == nil {
            return nil
        }
        
        // Need to update record and album if this is the most unique on the record
        let _ = track.record?.removeTrack(track)
        
        var newUnique: Track?
        var uniqueness: Uniqueness?
        
        let indexVersion = (byVersion?.firstIndex(of: track))!
        byVersion?.remove(at: indexVersion)
        // This tracks need their uniquness updated
        if byVersion?.count == 1 {
            newUnique = byVersion?[0]
            uniqueness = Uniqueness.artist
        }
    
        let indexArtist = (byArtist?.firstIndex(of: track))!
        byArtist?.remove(at: indexArtist)
        // This tracks need their uniquness updated
        if byArtist?.count == 1 {
            newUnique = byArtist?[0]
            uniqueness = Uniqueness.title
        }
        
        let indexTitle = (byTitle?.firstIndex(of: track))!
        byTitle?.remove(at: indexTitle)
        // This tracks need their uniquness updated
        if byTitle?.count == 1 {
            newUnique = byTitle?[0]
            uniqueness = Uniqueness.unique
        }

        if newUnique != nil {
            return NewUnique.newUnique(track: newUnique!, uniqueness: uniqueness!)
        } else {
            return NewUnique.none
        }
    }
}
