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
    let url: String
    let images: [ImageWrapper]
    let dates: StartDateWrapper
    let priceRanges: [PriceWrapper]
}

struct ImageWrapper: Decodable, Hashable {
    let url: String
}

struct StartDateWrapper: Decodable, Hashable {
    let start: StartWrapper
}

struct StartWrapper: Decodable, Hashable {
    let localDate: String
    let localTime: String
}

struct PriceWrapper: Decodable, Hashable {
    let currency: String
    let min: Double
    let max: Double
}
