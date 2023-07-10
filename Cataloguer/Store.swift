//
//  Store.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/8/23.
//

import Foundation

class Store: Equatable {
    static func == (lhs: Store, rhs: Store) -> Bool {
        (lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame) && (lhs.location.caseInsensitiveCompare(rhs.location) == .orderedSame)
    }
    
    var name: String = ""
    var location: String = ""
    var timeSpentBuying: Int = 0
    var timeSpentSelling: Int = 0
    var recordsBought: Int = 0
    var recordsSold: Int = 0
    var totalSpent: Double = 0
    var totalEarned: Double = 0
    var totalTrips: Int = 0
    var tripsBuying: Int = 0
    var tripsSelling: Int = 0
    var travelTime: Int = 0
}
