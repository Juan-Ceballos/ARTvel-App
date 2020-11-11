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
        
        detailTMView.priceLabel.text = String(currentEvent.priceRanges?.first?.max ?? 0)
    }

}
