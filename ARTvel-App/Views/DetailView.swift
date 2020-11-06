//
//  DetailView.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/5/20.
//

import UIKit
import SnapKit

class DetailView: UIView {
    
    public lazy var displayImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "book")
        return iv
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
        setupDisplayImageConstraints()
    }
    
    private func setupDisplayImageConstraints() {
        addSubview(displayImage)
        
        displayImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(self.snp.height)
        }
    }
    
}
