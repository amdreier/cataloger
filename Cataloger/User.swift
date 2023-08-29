//
//  User.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/10/23.
//

import Foundation
import CoreData



/// - TODO: Figure out storing/adding/removing unique tracks with multiple filiters
class User: NSManagedObject {
//    @Published var username: String = ""
//    @Published var catalog: Catalog = Catalog()
//    @Published var albumWishlist = [Album]()
//    @Published var trackWishlist = [Track]()
//    @Published var trips = [Trip]()
    
    
    
//    @Published var statistics = Statistics()
    
    let context: NSManagedObjectContext = NSManagedObjectContext()
    
    init(context: NSManagedObjectContext) {
        super.init(entity: NSEntityDescription(), insertInto: context)
        self.context = context
    }
    
    func setUsername(username: String) {
        self.usernameDat = username
    }
    
    func startTrip() -> Trip {
        let newTrip = Trip(context: context, self)
        addToTripsDat(newTrip)
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
