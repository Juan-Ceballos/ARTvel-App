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
    let favID: String
    let url: String
    let images: [ImageWrapper]
    let dates: StartDateWrapper
    let priceRanges: [PriceWrapper]?
    let dateFavorited: Date
}

struct ImageWrapper: Decodable, Hashable {
    let url: String
}

struct StartDateWrapper: Decodable, Hashable {
    let start: StartWrapper
}

struct StartWrapper: Decodable, Hashable {
    let localDate: String
    let localTime: String?
}

struct PriceWrapper: Decodable, Hashable {
    let currency: String
    let min: Double
    let max: Double
}

extension Event {
    init(_ dictionary: [String:Any], _ imagesURLDict: [String:Any], _ datesDictionary: [String:Any], _ priceRangeDictionary: [String:Any]) {
        self.name = dictionary["eventName"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""
        self.url = dictionary["url"] as? String ?? ""
        self.images = [ImageWrapper(imagesURLDict)]
        self.dates = StartDateWrapper(datesDictionary)
        self.priceRanges = [PriceWrapper(priceRangeDictionary)]
        self.favID = UUID().uuidString
        self.dateFavorited = Date()
    }
}

extension ImageWrapper {
    init(_ dictionary: [String:Any]) {
        self.url = dictionary["images"] as? String ?? ""
    }
}

extension StartDateWrapper {
    init(_ dictionary: [String:Any]) {
        self.start = StartWrapper(dictionary)
    }
}

extension StartWrapper {
    init(_ dictionary: [String:Any]) {
        self.localDate = dictionary["date"] as? String ?? ""
        self.localTime = dictionary["time"] as? String
    }
}

extension PriceWrapper {
    init(_ dictionary: [String: Any]) {
        self.currency = dictionary["currency"] as? String ?? ""
        self.min = dictionary["priceRangeMin"] as? Double ??  0.0
        self.max = dictionary["priceRangeMax"] as? Double ?? 0.0
    }
}
