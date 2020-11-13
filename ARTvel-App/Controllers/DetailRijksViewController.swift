//
//  DetailViewController.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/5/20.
//

import UIKit
import Kingfisher

class DetailRijksViewController: UIViewController {

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
