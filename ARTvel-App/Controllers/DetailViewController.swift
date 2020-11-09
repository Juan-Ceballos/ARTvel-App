//
//  DetailViewController.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/5/20.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    var currentArtItem: ArtObject?
    
    let detailView = DetailRijksView()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        configureUI()
    }
    
    private func configureUI() {
        guard let displayItem = currentArtItem else {
            fatalError()
        }
        
        //displayImage goes here
        let url = URL(string: displayItem.webImage.url)
        detailView.displayImageView.kf.setImage(with: url)
        detailView.titleLabel.text = displayItem.title
        
        // fetch detail of art object to populate detail view ui, setup elements and constraints in detailview, and fetch and populate here calling said elements
        
        RijksAPIClient.fetchDetailsOfArtObject(objectNumber: displayItem.objectNumber) { (result) in
            switch result {
            case .failure(let error):
                break
            case .success(let objectDetail):
                break
            }
        }
    }

}
