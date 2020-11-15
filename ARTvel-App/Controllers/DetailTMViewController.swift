//
//  DetailTMViewController.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/10/20.
//

import UIKit

class DetailTMViewController: UIViewController {

    let detailTMView = DetailTicketMasterView()
    var tmEvent: Event?
    var eventImage: UIImage?
    
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
        view = detailTMView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = rBButton
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(favoriteButtonPressed)
        checkFavorite()
        configureUI()
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
        isFavorite.toggle()
        print("favorite button pressed")
    }
    
    private func configureUI() {
        guard let currentEvent = tmEvent else {
            fatalError()
        }
        let url = URL(string: currentEvent.images.first?.url ?? "")
        let dateString = currentEvent.dates.start.localTime
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let date = dateFormatter.date(from: dateString ?? "")
        dateFormatter.dateFormat = "h:mm a"
        let dateTwelve = dateFormatter.string(from: date!)
        
        detailTMView.detailEventImageView.kf.setImage(with: url)
        detailTMView.detailEventNameLabel.text = currentEvent.name
        detailTMView.detailEventDateLabel.text = "Date: \(currentEvent.dates.start.localDate)"
        detailTMView.detailEventTimeLabel.text = "Local Start Time: \(dateTwelve)"
        detailTMView.priceLabel.text = "Price Range: $\(String(currentEvent.priceRanges?.first?.min ?? 0))0 - $\(String(currentEvent.priceRanges?.first?.max ?? 0))0"
    }

}


