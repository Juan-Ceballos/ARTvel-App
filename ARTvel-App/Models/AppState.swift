//
//  AppState.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/2/20.
//

import Foundation
import FirebaseFirestore

struct AppState {
    enum State {
        case rijks
        case ticketMaster
    }
    
    var state: State
}
