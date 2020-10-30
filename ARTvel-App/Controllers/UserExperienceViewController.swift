//
//  UserExperienceViewController.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import UIKit

class UserExperienceViewController: UIViewController {

    let userExperienceView = UserExperienceView()
    let db = DatabaseService()
    
    override func loadView() {
        view = userExperienceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        userExperienceView.experiencePickerView.dataSource = self
        userExperienceView.experiencePickerView.delegate = self
        userExperienceView.confirmButton.addTarget(self, action: #selector(experienceConfirmed), for: .touchUpInside)
        userExperienceView.cancelButton.addTarget(self, action: #selector(experienceCanceled), for: .touchUpInside)
        
    }
    
    @objc private func experienceConfirmed()  {
        print("experience confirmed")
        if userExperienceView.experiencePickerView.selectedRow(inComponent: 0) == 0 {
            db.updateDatabaseUser(userExperience: "rijks") { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success:
                    print("experience rijks added to database")
                }
            }
            print("rijks")
        } else {
            db.updateDatabaseUser(userExperience: "ticketmaster") { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success:
                    print("experience ticketmaster added to database")
                }
            }
            print("ticketmaster")
        }
        UIViewController.showVC(viewcontroller: MainTabBarController())
    }
    
    @objc private func experienceCanceled() {
        UIViewController.showVC(viewcontroller: LoginViewController())
    }

}

extension UserExperienceViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
}

extension UserExperienceViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "Rijksmuseum"
        } else {
            return "Ticketmaster"
        }
    }
}
