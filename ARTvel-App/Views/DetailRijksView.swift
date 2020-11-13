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
    
    public lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.allowsEditingTextAttributes = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = .systemFont(ofSize: 17)
        return textView
    }()
    
    public lazy var dateCreatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Year:"
        return label
    }()
    
    public lazy var placeProducedLabel: UILabel = {
        let label = UILabel()
        label.text = "Location:"
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
        setupDescriptionTextViewConstraints()
        setupDateCreatedConstraints()
        setupPlaceProducedLabelConstraints()
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
            make.left.equalToSuperview().offset(11)
            make.right.equalTo(self.snp.centerX)
        }
    }
    
    private func setupDescriptionTextViewConstraints() {
        addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.left.equalToSuperview().offset(11)
            make.right.equalToSuperview().offset(-11)
        }
    }
    
    private func setupDateCreatedConstraints() {
        addSubview(dateCreatedLabel)
        dateCreatedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(11)
            make.left.equalToSuperview().offset(11)
            make.right.equalTo(self.snp.centerX)
        }
    }
    
    private func setupPlaceProducedLabelConstraints() {
        addSubview(placeProducedLabel)
        placeProducedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateCreatedLabel.snp.bottom).offset(11)
            make.left.equalToSuperview().offset(11)
            make.right.equalTo(self.snp.centerX)
        }
    }
    
}
