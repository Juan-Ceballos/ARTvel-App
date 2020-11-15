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
        db.collection(DatabaseService.favoriteCollectionRijks).document(artItem.objectNumber).setData(["artImageURL" : artItem.webImage.url,
                                    "artTitle" : artItem.title,
                                    "artObjectNumber" : artItem.objectNumber,
                                    "userID" : user.uid
        ]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func removeFromFavoriteRijks(artItem: ArtObject, completion: @escaping (Result<Bool, Error>) -> ()) {
        db.collection(DatabaseService.favoriteCollectionRijks).document(artItem.objectNumber).delete { (error) in
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
