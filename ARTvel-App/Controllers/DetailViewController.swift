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
    
    let detailView = DetailView()
    
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
        detailView.displayImage.kf.setImage(with: url)
        
    }

}
