//
//  Store.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/8/23.
//

import Foundation
import CoreData


/// - TODO: Add metric calculations
///     - Breakdowns of metrics by genre
class Store: NSManagedObject {
//    var name: String = ""
//    var location: String = ""
//    var statistics = Statistics()
    
    init(name: String, location: String) {
        super.init()
        
        self.name = name
        self.location = location
    }
    
    static func ==(lhs: Store, rhs: Store) -> Bool {
        (lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame) && (lhs.location.caseInsensitiveCompare(rhs.location) == .orderedSame)
    }
}
