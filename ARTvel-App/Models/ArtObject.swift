//
//  ArtObject.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import Foundation

struct ArtObjectWrapper: Decodable {
    let artObjects: [ArtObject]
}

struct ArtObject: Decodable, Hashable {
    let objectNumber: String
    let title: String
    let webImage: WebImage
}

struct WebImage: Decodable, Hashable {
    let url: String
}

struct DetailArtObjectWrapper: Decodable {
    let artObject: ArtObjectDetails
}

struct ArtObjectDetails: Decodable {
    let plaqueDescriptionEnglish: String
    let dating: DateWrapper
    let productionPlaces: [String]
}

struct DateWrapper: Decodable {
    let presentingDate: String
}

extension ArtObject {
    init(_ dictionary: [String:Any], _ webImageDict: [String:Any]) {
        self.objectNumber = dictionary["artObjectNumber"] as? String ?? ""
        self.title = dictionary["artTitle"] as? String ?? ""
        self.webImage = WebImage(webImageDict)
    }
}

extension WebImage {
    init(_ dictionary: [String:Any]) {
        self.url = dictionary["artImageURL"] as? String ?? ""
    }
}

