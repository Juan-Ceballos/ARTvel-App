//
//  FavoriteCell.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/13/20.
//

import UIKit
import SnapKit

class FavoriteCell: UICollectionViewCell {
    static let reuseIdentifier = "favoriteCell"
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.systemBackground.cgColor
    }
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        return iv
    }()
    
    public lazy var eventNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    public lazy var eventDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    public lazy var eventTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupImageViewConstraints()
        setupEventNameLabelConstraints()
        //setupEventDateLabelConstraints()
        //setupEventTimeLabelConstraints()
    }
    
    private func setupImageViewConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    private func setupEventNameLabelConstraints()    {
        addSubview(eventNameLabel)
        eventNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.centerY)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
    
    private func setupEventDateLabelConstraints() {
        addSubview(eventDateLabel)
        eventDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(eventNameLabel.snp.bottom).offset(8)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
    
    
    private func setupEventTimeLabelConstraints()   {
        addSubview(eventTimeLabel)
        eventTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(eventDateLabel.snp.bottom).offset(8)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
}
