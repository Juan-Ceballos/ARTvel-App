//
//  MainTabBarController.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    
    public lazy var searchVC: UIViewController = {
        let vc = SearchViewController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return vc
    }()

    public lazy var favoritesVC: UIViewController = {
        let vc = FavoritesViewController()
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        return vc
    }()

    public lazy var settingsVC: UIViewController = {
        let vc = SettingsViewController()
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return vc
    }()

    let authSession = AuthSession()


    override func viewDidLoad() {
        super.viewDidLoad()
        //authSession.signOutCurrentUser()

        viewControllers = [UINavigationController(rootViewController: searchVC), favoritesVC, settingsVC]
    }
    
}
