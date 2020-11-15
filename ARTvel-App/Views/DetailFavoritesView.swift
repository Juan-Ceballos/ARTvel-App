//
//  DetailFavoritesView.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/15/20.
//

import UIKit
import SnapKit

class DetailFavoritesView: UIView {
    
    public lazy var nameLabel: UILabel = {
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
        setupNameLabelConstraints()
    }
    
    private func setupNameLabelConstraints() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
}
