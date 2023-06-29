//
//  CharacterResponses.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 17/04/23.
//

import Foundation

///Para ser decodable, é necessário que todas as dependências sejam decodable
struct CharacterResponses: Codable {
     var results: [Characters]
}

struct Characters: Codable {
    var id: Int
    var name: String
    var species: String
    var origin: Characters.Location
    var status: String
    var image: String?
    
    struct Location: Codable {
        var name: String
        
    }
}
