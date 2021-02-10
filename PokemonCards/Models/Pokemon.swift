//
//  Pokemon.swift
//  PokemonCards
//
//  Created by Elīna Zekunde on 09/02/2021.
//

import Foundation

struct Pokemon: Decodable {
    // can set var name as an explanation if needed
    let name: String
    var imageUrl: String?
    //let number_Card: String
    let number: String
    let rarity: String
    let hp: String?
    let subtype: String?
    let supertype: String?
    
    // in enum case has to match the json or value must be provided that matches
    // otherwise it will not fetch data
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl
        //case number_Card = "number"
        case number
        case rarity
        case hp
        case subtype, supertype
    }
}

// cards is an array of dictionaries
struct Card: Decodable {
    let cards: [Pokemon]
}
