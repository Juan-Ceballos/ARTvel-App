//
//  DatabaseService.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
    static let usersCollection = "users"
    static let favoriteCollectionRijks = "favoritesRijks"
    static let favoriteCollectionTM = "favoritesTM"
    
    private let db = Firestore.firestore()
    
    public func createDatabaseUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ())    {
        guard let email = authDataResult.user.email else {
            return
        }
        db.collection(DatabaseService.usersCollection)
            .document(authDataResult.user.uid)
            .setData(["email" : email,
                      "createdDate": Timestamp(date: Date()),
                      "userId": authDataResult.user.uid]) { (error) in
                
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
    }
    
    public func addToFavoriteRijks(artItem: ArtObject, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {return}
        
        let docRef = db.collection(DatabaseService.favoriteCollectionRijks).document()
        print("docRef is \(docRef)")
        
        db.collection(DatabaseService.favoriteCollectionRijks).document(docRef.documentID).setData([
            
            "artImageURL" : artItem.webImage.url,
                                                                                                    
            "artTitle" : artItem.title,
                                                                                                    
            "artObjectNumber" : artItem.objectNumber,
                                                                                                    
            "userID" : user.uid,
                                                                                                    
            "favRijksID": docRef.documentID
            
        ]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func addToFavoriteEvents(eventItem: Event, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {return}
        
        let docRef = db.collection(DatabaseService.favoriteCollectionTM).document()
        print("docRef is \(docRef)")
        
        db.collection(DatabaseService.favoriteCollectionTM).document(docRef.documentID).setData([
            
            "eventName" : eventItem.name,
                                                                                                 
            "id" : eventItem.id,
                                                                                                 
            "url" : eventItem.url,
                                                                                                 
            "images" : eventItem.images.first?.url ?? "",
                                                                                                 
            "date" : eventItem.dates.start.localDate,
                                                                                                 
            "time" : eventItem.dates.start.localTime ?? "",
                                                                                                 
            "currency": eventItem.priceRanges?.first?.currency ?? "",
                                                                                                 
            "priceRangeMin" : eventItem.priceRanges?.first?.min ?? 0.0,
                                                                                                 
            "priceRangeMax": eventItem.priceRanges?.first?.max ?? 0.0,
                                                                                                 
            "userID" : user.uid,
                                                                                                 
            "favEventID" : docRef.documentID
                                                                                                 
        ]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
            
        }
    }
    
    // might have to fix remove since document id is random
    public func removeFromFavoriteRijks(artItem: ArtObject, completion: @escaping (Result<Bool, Error>) -> ()) {
        db.collection(DatabaseService.favoriteCollectionRijks).document(artItem.objectNumber).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    // same here removeRijks
    public func removeFromFavoritesTM(eventItem: Event, completion: @escaping (Result<Bool, Error>) -> ()) {
        db.collection(DatabaseService.favoriteCollectionTM).document(eventItem.id).delete() { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func getAllFavoriteRijksItems(completion: @escaping (Result<[ArtObject], Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser else {return}
        
        db.collection(DatabaseService.favoriteCollectionRijks).whereField("userID", isEqualTo: user.uid).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            
            if let snapshot = snapshot {
                let favItems = snapshot.documents.map{ArtObject($0.data(), $0.data())}
                completion(.success(favItems))
            }
        }
    }
    
    public func getAllFavoriteDatabaseItems(completion: @escaping (Result<[Event], Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {return}
        db.collection(DatabaseService.favoriteCollectionTM).whereField("userID", isEqualTo: user.uid).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let snapshot = snapshot {
                let favItems = snapshot.documents.map{Event($0.data(), $0.data(), $0.data(), $0.data())}
                completion(.success(favItems))
            }
        }
    }
    
    func updateDatabaseUser(userExperience: String,
                            completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.usersCollection)
            .document(user.uid).updateData(["userExperience": userExperience]) { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
    }
    
    func getUserExperienceForUser(completion: @escaping (Result<String?, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {return}
        db.collection(DatabaseService.usersCollection).document(user.uid).getDocument { (snapshot, error) in
            if let error = error    {
                completion(.failure(error))
            }
            
            else if let snapshot = snapshot {
                let userExperienceStored = snapshot.get("userExperience") as? String
                completion(.success(userExperienceStored))
            }
        }
    }
    
    
}
