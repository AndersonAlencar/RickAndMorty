//
//  Character.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 18/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

struct Character {
    var id: String
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Origin
    var location: CharacterLocation
    var image: String
    var episode: [String]
    var url: String
}

struct CharacterLocation: Codable {
    var name: String
    var url: String
}
