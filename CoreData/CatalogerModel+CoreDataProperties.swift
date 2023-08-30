//
//  CatalogerModel+CoreDataProperties.swift
//  Cataloger
//
//  Created by Alex Dreier on 8/24/23.
//
//

import Foundation
import CoreData


extension CatalogerModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatalogerModel> {
        return NSFetchRequest<CatalogerModel>(entityName: "CatalogerModel")
    }

    @NSManaged public var storesDat: NSSet?
    @NSManaged public var userDat: User?

    public var user: User {
        userDat ?? {print("nu"); return User(context: context!)}()
    }
    
    public var stores: [Store] {
        let storeSet = storesDat as? Set<Store> ?? []
        
        return storeSet.sorted {
            $0.name < $1.name
        }
    }
    
}

// MARK: Generated accessors for storesDat
extension CatalogerModel {

    @objc(addStoresDatObject:)
    @NSManaged public func addToStoresDat(_ value: Store)

    @objc(removeStoresDatObject:)
    @NSManaged public func removeFromStoresDat(_ value: Store)

    @objc(addStoresDat:)
    @NSManaged public func addToStoresDat(_ values: NSSet)

    @objc(removeStoresDat:)
    @NSManaged public func removeFromStoresDat(_ values: NSSet)

}

extension CatalogerModel : Identifiable {

}
