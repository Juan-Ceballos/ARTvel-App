//
//  TicketMasterCell.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/29/20.
//

import Foundation
import SnapKit

class TicketMasterCell: UICollectionViewCell {
    static let reuseIdentifier = "ticketMasterCell"
    
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
    
    public lazy var startEventDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    public lazy var endEventDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    public lazy var startEventTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    public lazy var endEventTimeLabel: UILabel = {
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
        setupStartEventDateLabelConstraints()
        setupStartEventTimeLabelConstraints()
        setupEndEventDateLabelConstraints()
        setupEndEventTimeLabelConstraints()
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
            make.top.equalTo(self.snp.top).offset(11)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
    
    private func setupStartEventDateLabelConstraints() {
        addSubview(startEventDateLabel)
        startEventDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(eventNameLabel.snp.bottom).offset(16)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
    
    private func setupStartEventTimeLabelConstraints()   {
        addSubview(startEventTimeLabel)
        startEventTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startEventDateLabel.snp.bottom).offset(8)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
    
    private func setupEndEventDateLabelConstraints() {
        addSubview(endEventDateLabel)
        endEventDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startEventTimeLabel.snp.bottom).offset(8)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
    
    private func setupEndEventTimeLabelConstraints() {
        addSubview(endEventTimeLabel)
        endEventTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(endEventDateLabel.snp.bottom).offset(8)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
    
    
}
