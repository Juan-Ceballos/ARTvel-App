//
//  DetailView.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/5/20.
//

import UIKit
import SnapKit

class DetailRijksView: UIView {
    
    public lazy var displayImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "book")
        return iv
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        setupDisplayImageConstraints()
        setupTitleLabelConstraints()
    }
    
    private func setupDisplayImageConstraints() {
        addSubview(displayImageView)
        
        displayImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalToSuperview()
        }
    }
    
    private func setupTitleLabelConstraints() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(displayImageView.snp.bottom).offset(11)
            make.left.equalToSuperview().offset(8)
            make.right.equalTo(self.snp.centerX)
        }
    }
    
}
