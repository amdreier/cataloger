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

@objc(Store)
class Store: NSManagedObject {
//    var name: String = ""
//    var location: String = ""
//    var statistics = Statistics()
    
    
    let context: NSManagedObjectContext? = nil
    
    init(context: NSManagedObjectContext, name: String, location: String) {
        super.init(entity: NSEntityDescription.entity(forEntityName: "Store", in: context)!, insertInto: context)
        
        self.context = context
        self.nameDat = name
        self.locationDat = location
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        
        self.context = context!
    }
    
    static func ==(lhs: Store, rhs: Store) -> Bool {
        (lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame) && (lhs.location.caseInsensitiveCompare(rhs.location) == .orderedSame)
    }
}
