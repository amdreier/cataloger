//
//  Store.swift
//  Cataloguer
//
//  Created by Alex Dreier on 7/8/23.
//

import Foundation


/// - TODO: Add metric calculations
///     - Breakdowns of metrics by genre
class Store: Equatable, Hashable {
    var name: String = ""
    var location: String = ""
    var statistics = Statistics()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    static func ==(lhs: Store, rhs: Store) -> Bool {
        (lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame) && (lhs.location.caseInsensitiveCompare(rhs.location) == .orderedSame)
    }
}
