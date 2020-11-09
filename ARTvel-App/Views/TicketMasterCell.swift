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
        //setupEventNameLabelConstraints()
    }
    
    private func setupImageViewConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
    }
    
    private func setupEventNameLabelConstraints()    {
        addSubview(eventNameLabel)
        eventNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
    
    private func setupEventTimeLabelConstraints()   {
        
    }
}
