//
//  SettingsViewController.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    let authSession = AuthSession()
    let settingsView = SettingsView()
    
    override func loadView() {
        view = settingsView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        settingsView.signOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
       
    }
    
    @objc private func signOutButtonPressed() {
        authSession.signOutCurrentUser()
        UIViewController.showVC(viewcontroller: LoginViewController())
    }
   

}
