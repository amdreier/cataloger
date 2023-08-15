//
//  User.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/10/23.
//

import Foundation



/// - TODO: Figure out storing/adding/removing unique tracks with multiple filiters
class User {
    var username: String = ""
    var catalogue: Catalogue = Catalogue()
    var albumWishlist = [Album]()
    var trackWishlist = [Track]()
    var trips = [Trip]()
    
    func setUsername(username: String) {
        self.username = username
    }
    
    func startTrip() -> Trip {
        let newTrip = Trip(self)
        trips.append(newTrip)
        return newTrip
    }
    
    func tripsString() -> String {
        var output = ""
        for trip in trips {
            output += trip.description + ", "
        }
        
        return output
    }
}
