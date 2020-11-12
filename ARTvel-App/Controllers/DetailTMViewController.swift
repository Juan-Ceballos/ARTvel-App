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
    
    override func loadView() {
        view = detailTMView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    private func configureUI() {
        guard let currentEvent = tmEvent else {
            fatalError()
        }
        let url = URL(string: currentEvent.images.first?.url ?? "")
        
        detailTMView.detailEventImageView.kf.setImage(with: url)
        detailTMView.detailEventNameLabel.text = currentEvent.name
        detailTMView.detailEventDateLabel.text = "Date: \(currentEvent.dates.start.localDate)"
        detailTMView.detailEventTimeLabel.text = "Local Start Time: \(currentEvent.dates.start.localTime ?? "")"
        detailTMView.priceLabel.text = "Price Range: $\(String(currentEvent.priceRanges?.first?.min ?? 0))0 - $\(String(currentEvent.priceRanges?.first?.max ?? 0))0"
    }

}
