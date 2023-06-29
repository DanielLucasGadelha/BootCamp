//
//  LocationListResponses.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 19/04/23.
//

import Foundation

struct LocationResponses: Decodable {
    
    let results: [Location]
    
}

struct Location: Decodable {
    
    let id: Int
    let name: String
    let type: String
    let dimension: String
}
