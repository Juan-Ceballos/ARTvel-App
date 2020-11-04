//
//  Event.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import Foundation

struct EventWrapper: Decodable {
    let embedded: EventQuery
    
    private enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct EventQuery: Decodable {
    let events: [Event]
}

struct Event: Decodable, Hashable {
    let name: String
    let id: String
}
