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
    
    public lazy var detailEventNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    public lazy var detailEventDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public lazy var detailEventTimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public lazy var detailEventImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    public lazy var urlLabel: UILabel = {
        let label = UILabel()        
        label.text = "Title"
        label.isUserInteractionEnabled = true
        
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
        setupDetailEventImageViewConstraints()
        setupDetailEventNameLabelConstraints()
        setupDetailEventDateLabelConstraints()
        setupDetailEventTimeLabelConstraints()
        setupPriceLabelConstraints()
        setupURLLabelConstraints()
    }
    
    private func setupDetailEventImageViewConstraints() {
        addSubview(detailEventImageView)
        detailEventImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
        }
    }
    
    private func setupDetailEventNameLabelConstraints() {
        addSubview(detailEventNameLabel)
        detailEventNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailEventImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(11)
            make.right.equalToSuperview().offset(-11)
        }
    }
    
    private func setupDetailEventDateLabelConstraints() {
        addSubview(detailEventDateLabel)
        detailEventDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailEventNameLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(11)
            make.right.equalToSuperview().offset(-11)
        }
    }
    
    private func setupDetailEventTimeLabelConstraints() {
        addSubview(detailEventTimeLabel)
        detailEventTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailEventDateLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(11)
            make.right.equalToSuperview().offset(-11)
        }
    }
    
    private func setupPriceLabelConstraints() {
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailEventTimeLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(11)
            make.right.equalToSuperview().offset(-11)
        }
    }
    
    private func setupURLLabelConstraints() {
        addSubview(urlLabel)
        urlLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(11)
            make.right.equalToSuperview().offset(-11)
        }
    }
    
}
