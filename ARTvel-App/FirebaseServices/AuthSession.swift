//
//  AuthSession.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import Foundation
import FirebaseAuth

class AuthSession {
    func createNewUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> ())    {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let authDataResult = authDataResult {
                completion(.success(authDataResult))
            }
        }
    }
    
    public func signExistingUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
      Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
        if let error = error {
          completion(.failure(error))
        }
        else if let authDataResult = authDataResult {
          completion(.success(authDataResult))
        }
      }
    }
    
    public func signOutCurrentUser()    {
        do  {
            try Auth.auth().signOut()
        }
        catch   {
            print(error.localizedDescription)
        }
    }
    
}
