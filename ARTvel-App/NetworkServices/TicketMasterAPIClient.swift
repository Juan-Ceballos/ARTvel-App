//
//  TicketMasterAPIClient.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import Foundation

class TicketMasterAPIClient {
    static func fetchEvents(stateCode: String, city: String, postalCode: String, completion: @escaping (Result<[Event], AppError>) -> ())   {
        // basic call then add querys
        // how can they search to add querys
        // postal code, city, statecode
        
        //let stateCode = ""
        //let city = ""
        //let postalCode = ""
        
        let endpointURL = "https://app.ticketmaster.com/discovery/v2/events.json?stateCode=\(stateCode)&city=\(city)&postalCode=\(postalCode)&apikey=\(SecretKey.consumerKey)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request: urlRequest) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let eventQuery = try JSONDecoder().decode(EventWrapper.self, from: data)
                    let events = eventQuery.embedded.events
                    completion(.success(events))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
