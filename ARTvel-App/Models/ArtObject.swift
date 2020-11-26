//
//  ArtObject.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import Foundation
import FirebaseFirestore

struct ArtObjectWrapper: Decodable {
    let artObjects: [ArtObject]
}

struct ArtObject: Decodable, Hashable {
    let objectNumber: String
    let title: String
    let webImage: WebImage
    var favArtID: String?
    var userID: String?
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
        self.objectNumber = dictionary["objectNumber"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.webImage = WebImage(webImageDict)
        
        self.favArtID = dictionary["favArtID"] as? String
        
        self.userID = dictionary["userID"] as? String
    }
}

extension WebImage {
    init(_ dictionary: [String:Any]) {
        self.url = dictionary["webImage"] as? String ?? ""
    }
}

