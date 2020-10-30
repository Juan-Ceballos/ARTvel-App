//
//  AppError.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import Foundation

public enum AppError: Error {
    case badURL(String)
    case networkClientError(Error)
    case decodingError(Error)
    case noResponse
    case noData
    case badStatusCode(Int)
}
