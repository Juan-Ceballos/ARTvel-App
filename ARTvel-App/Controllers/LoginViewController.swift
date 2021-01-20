//
//  LoginViewController.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import UIKit
import FirebaseAuth
import SnapKit

class LoginViewController: UIViewController {

    let authSession = AuthSession()
    let db = DatabaseService()
    let userExperienceVC = UserExperienceViewController()
    let loginView = LoginView()
    private var keyboardIsVisible = false
    var originalYConstraint: CGFloat?
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        view.backgroundColor = UIColor(red: 51/255, green: 66/255, blue: 63/255, alpha: 1)
        loginView.passwordTextField.delegate = self
        loginView.usernameTextField.delegate = self
        loginView.createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        loginView.signedUpUserButton.addTarget(self, action: #selector(signinButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterForKeyboardNotifications()
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterForKeyboardNotifications()   {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        //print("keyboardWillShow")
        
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect else  {
            return
        }
        
        if loginView.passwordTextField.isEditing {
            moveKeyboardUp(keyboardFrame.size.height - 17)
        }
        else {
            moveKeyboardUp(keyboardFrame.size.height)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        //print("keyboardWilllHide")
    }
    
    private func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible { return }
        originalYConstraint = height
        loginView.signedUpUserButton.frame.origin.y -= height
        print(loginView.signedUpUserButton.frame.origin.y)
        print("\(height) height of key up")
        loginView.createAccountButton.frame.origin.y -= 55
        loginView.passwordTextField.frame.origin.y -= 55
        loginView.usernameTextField.frame.origin.y -= 55
        UIView.animate(withDuration: 0.5)   {
            self.view.layoutIfNeeded()
        }
        
        keyboardIsVisible = true
    }
    
    private func resetUI()  {
        keyboardIsVisible = false
        loginView.signedUpUserButton.frame.origin.y += (originalYConstraint ?? 0)
        print(loginView.signedUpUserButton.frame.origin.y)
        print("\(originalYConstraint) og reset")
        loginView.createAccountButton.frame.origin.y += 55
        loginView.passwordTextField.frame.origin.y += 55
        loginView.usernameTextField.frame.origin.y += 55
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func signinExistingUser(email: String, password: String) {
        authSession.signExistingUser(email: email, password: password) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success:
                self?.db.getUserExperienceForUser { (result) in
                    switch result   {
                    case .failure(let error):
                        print(error)
                    case .success(let experience):
                        DispatchQueue.main.async {
                            if let experienceDB = experience {
                                self?.navigateToMainView(experience: experienceDB)
                            } else {
                                self?.navigateToUserExperience()
                            }
                        }
                    }
                }
            }
          }
    }
    
    private func createDatabaseUser(authDataResult: AuthDataResult)   {
        db.createDatabaseUser(authDataResult: authDataResult) { [weak self] (result) in
          switch result {
          case .failure(let error):
            DispatchQueue.main.async {
              self?.showAlert(title: "Account error", message: error.localizedDescription)
            }
          case .success:
            DispatchQueue.main.async {
              self?.navigateToUserExperience()
            }
          }
        }
    }
    
    private func createNewUser(email: String, password: String) {
        authSession.createNewUser(email: email, password: password) { [weak self] (result) in
            switch result   {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let authDataResult):
                self?.createDatabaseUser(authDataResult: authDataResult)
            }
        }
    }
    
    private func navigateToMainView(experience: String)   {
        UIViewController.showVC(viewcontroller: MainTabBarController(experience: experience))
    }
    
    private func navigateToUserExperience() {
        UIViewController.showVC(viewcontroller: userExperienceVC)
    }
    
    @objc func createAccountButtonPressed() {
        guard let email = loginView.usernameTextField.text,
            !email.isEmpty,
            let password = loginView.passwordTextField.text,
            !password.isEmpty
        else    {
            print("missing fields")
            return
        }
        
        createNewUser(email: email, password: password)
    }
    
    @objc func signinButtonPressed()  {
        guard let email = loginView.usernameTextField.text,
            !email.isEmpty,
            let password = loginView.passwordTextField.text,
            !password.isEmpty
        else    {
            print("missing fields")
            return
        }
        
        signinExistingUser(email: email, password: password)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let maxPasswordLength = 18
        let maxUserNameLength = 36
        
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == loginView.passwordTextField {
            return updatedText.count <= maxPasswordLength
        }
        else {
            return updatedText.count <= maxUserNameLength
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        resetUI()
        return true
    }
}
