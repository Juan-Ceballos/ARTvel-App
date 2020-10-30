//
//  RijksAPIClient.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import Foundation

class RijksAPIClient {
    public static func fetchArtObjects(searchQuery: String, completion: @escaping (Result<[ArtObject], AppError>) -> ())   {
        
        let urlSearchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let urlEndpoint = "https://www.rijksmuseum.nl/api/nl/collection?key=\(SecretKey.apiKey)&involvedMaker=\(urlSearchQuery)"
        
        guard let url = URL(string: urlEndpoint) else {
            completion(.failure(.badURL(urlEndpoint)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request: urlRequest) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                dump(data)
                // set up model to parse into array for a table view
                do {
                    let artCollection = try JSONDecoder().decode(ArtObjectWrapper.self, from: data)
                    let artObjects = artCollection.artObjects
                    completion(.success(artObjects))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    public static func fetchDetailsOfArtObject(objectNumber: String, completion: @escaping (Result<ArtObjectDetails, AppError>) -> ())    {
        let urlEndpoint = "https://www.rijksmuseum.nl/api/nl/collection/\(objectNumber)?key=\(SecretKey.apiKey)"
        
        guard let url = URL(string: urlEndpoint) else {
            completion(.failure(.badURL(urlEndpoint)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request: urlRequest) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let detailsObject = try JSONDecoder().decode(DetailArtObjectWrapper.self, from: data)
                    let details = detailsObject.artObject
                    completion(.success(details))
                } catch  {
                    completion(.failure(.decodingError(error)))
                    return
                }
            }
        }
    }
}
