//
//  RijksCell.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/29/20.
//

import Foundation
import SnapKit

class RijksCell: UICollectionViewCell {
    static let reuseIdentifier = "rijksCell"
    
    override func layoutSubviews() {
        
    }
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        return iv
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 2
        return label
    }()
    
    public lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
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
        setupTitleLabelConstraints()
    }
    
    private func setupImageViewConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.width.equalToSuperview().multipliedBy(0.3)
            //make.right.equalTo(self.snp.right)
        }
    }
    
    private func setupTitleLabelConstraints()    {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
}
