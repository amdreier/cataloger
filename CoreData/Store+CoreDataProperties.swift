//
//  Store+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/25/23.
//
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store")
    }

    @NSManaged public var locationDat: String?
    @NSManaged public var nameDat: String?
    @NSManaged public var albumDat: Album?
    @NSManaged public var catalogerModelData: CatalogerModel?
    @NSManaged public var recordsDat: Record?
    @NSManaged public var statisticsDat: Statistics?
    @NSManaged public var stop: Stop?
    
    public var name: String {
        nameDat ?? ""
    }
    
    public var location: String {
        locationDat ?? ""
    }
    
    public var statistics: Statistics {
        statisticsDat ?? Statistics()
    }
}

extension Store : Identifiable {

}
