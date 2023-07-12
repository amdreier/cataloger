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
    var catalogue = [Album]()
    var uniqueTracks = [Track]()
    var albumWishlist = [Album]()
    var trackWishlist = [Track]()
}
