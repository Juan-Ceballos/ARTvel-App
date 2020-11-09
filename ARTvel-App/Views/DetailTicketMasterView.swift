//
//  DetailTicketMasterView.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/9/20.
//

import UIKit

class DetailTicketMasterView: UIView {
    
    public lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit()   {
       setupPriceLabelConstraints()
    }
    
    private func setupPriceLabelConstraints() {
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
}
