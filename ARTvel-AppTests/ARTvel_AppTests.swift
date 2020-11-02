//
//  ARTvel_AppTests.swift
//  ARTvel-AppTests
//
//  Created by Juan Ceballos on 10/28/20.
//

import XCTest
import FirebaseAuth
@testable import ARTvel_App

class ARTvel_AppTests: XCTestCase {

    // test list
    /*
     1. hitting api
     using key and secret to pull data from api
     dictionary json, key:value
     bulk is in "artObjects" : [ArtObjects]
     2. models
     3. classes
     4. firebase
     5.
     */
    
    func testNetworkHelperRijkCollectionsAPI()   {
        // arrange
        let searchQuery = "Rembrandt van Rijn".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let exp = XCTestExpectation(description: "Art Objects Found")
        let collectionEndpoint = "https://www.rijksmuseum.nl/api/nl/collection?key=\(SecretKey.apiKey)&involvedMaker=\(searchQuery)"
        let request = URLRequest(url: URL(string: collectionEndpoint)!)
        
        NetworkHelper.shared.performDataTask(request: request) { (result) in
            //exp.fulfill()
            switch result {
            case .failure(let error):
                print(error)
                XCTFail("\(error)")
            case .success(let data):
                exp.fulfill()
                XCTAssertGreaterThan(data.count, 20_000, "data should be greater than \(data.count)")
            }
        }
        wait(for: [exp], timeout: 5.0)
        // act
        // assert
    }
    
    func testFetchArtObjects()   {
        // arrange
        let searchQuery = "Rembrandt van Rijn"
        let exp = XCTestExpectation(description: "Art Objects Found")
        
        RijksAPIClient.fetchArtObjects(searchQuery: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let apiArtObjects):
                exp.fulfill()
                let numberOfArtItemsForQuery = apiArtObjects.count
                XCTAssertGreaterThan(numberOfArtItemsForQuery, 5)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
        //fetchArtObject(
        // act
        // assert
    }
    
    func testFetchDetailsOfArtObject() {
        // arrange
        let exp = XCTestExpectation(description: "got details for art object")
        
        let objectNumber = "SK-C-5"
        
        RijksAPIClient.fetchDetailsOfArtObject(objectNumber: objectNumber) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let details):
                exp.fulfill()
                let artDate = details.dating.presentingDate
                XCTAssertEqual(artDate, "1642")
            }
        }
        
        wait(for: [exp], timeout: 5.0)
        // act
        // assert
    }
    
    func testFetchEvents()  {
        // arrange
        // event will change
        let exp = XCTestExpectation(description: "got events")
        let expectedEventName = "Dave Chappelle - Controlled Danger"
        TicketMasterAPIClient.fetchEvents(stateCode: "", city: "", postalCode: "") { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let events):
                exp.fulfill()
                let firstEventName = events[0].name
                XCTAssertEqual(firstEventName, expectedEventName)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
        // act
        // assert
    }
    
    func testCreateAuthenticatedUser()  {
        // only works first time since user created than exist so not created again
        let email = "whateva@email.com"
        let password = "123456"
        let exp = expectation(description: "User Created")
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            exp.fulfill()
            if let error = error    {
                XCTFail("Failed to create user error: \(error.localizedDescription)")
            }   else if let authDataResult = authDataResult {
                XCTAssertEqual(authDataResult.user.email, email)
            }
        }
        
        wait(for: [exp], timeout: 3.0)
    }

}
