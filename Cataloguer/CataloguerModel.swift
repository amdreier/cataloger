//
//  CataloguerModel.swift
//  Cataloguer
//
//  Created by Alex Dreier on 8/14/23.
//

import Foundation

class CataloguerModel: ObservableObject {
    @Published var user = User()
    
    @Published var currentTrip: Trip? = nil
    
    func startTrip() {
        currentTrip = user.startTrip()
    }
}
