//
//  DatailFavoritesViewController.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/15/20.
//

import UIKit

class DetailFavoritesViewController: UIViewController {

    var artItem: ArtObject?
    
    let detailFavoriteView = DetailFavoritesView()
    
    override func loadView() {
        view = detailFavoriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    private func configureUI() {
        guard let currentArtObject = artItem else {
            fatalError()
        }
        print("configure")
        detailFavoriteView.nameLabel.text = currentArtObject.title
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
