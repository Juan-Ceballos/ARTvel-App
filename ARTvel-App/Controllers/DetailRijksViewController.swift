//
//  DetailViewController.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/5/20.
//

import UIKit
import Kingfisher
import FirebaseFirestore

class DetailRijksViewController: UIViewController {

    var currentArtItem: ArtObject?
    let db = DatabaseService()
    
    let detailView = DetailRijksView()
    let rBButton = UIBarButtonItem()
    
    private var isFavorite = false {
        didSet{
            if isFavorite {
                rBButton.image = UIImage(systemName: "heart.fill")
            }else{
                rBButton.image = UIImage(systemName: "heart")
            }
        }
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        configureUI()
        navigationItem.rightBarButtonItem = rBButton
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(favoriteButtonPressed)
        checkFavorite()
    }
    
    
    
    private func checkFavorite() {
        switch isFavorite {
        case true:
            rBButton.image = UIImage(systemName: "heart.fill")
        case false:
            rBButton.image = UIImage(systemName: "heart")

        }
    }
    
    @objc private func favoriteButtonPressed() {
        
        guard let displayItem = currentArtItem else {
            fatalError()
        }
        
        switch isFavorite {
        case true:
            isFavorite.toggle()
            db.removeFromFavoriteRijks(artItem: displayItem) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success:
                    print("deleted from favorites")
                }
            }
        case false:
            isFavorite.toggle()
            db.addToFavoriteRijks(artItem: displayItem) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success:
                    print("favorited")
                }
            }
        }
        
    }
    
    
    private func configureUI() {
        guard let displayItem = currentArtItem else {
            fatalError()
        }
        
        let url = URL(string: displayItem.webImage.url)
        detailView.displayImageView.kf.setImage(with: url)
        detailView.titleLabel.text = displayItem.title
        
        // date created, placed produced
        RijksAPIClient.fetchDetailsOfArtObject(objectNumber: displayItem.objectNumber) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let objectDetail):
                DispatchQueue.main.async {
                    self?.detailView.descriptionTextView.text = objectDetail.plaqueDescriptionEnglish
                    self?.detailView.dateCreatedLabel.text = "Year: \(objectDetail.dating.presentingDate)"
                    self?.detailView.placeProducedLabel.text = "Location: \(objectDetail.productionPlaces.first ?? "")"
                }
            }
        }
    }

}
