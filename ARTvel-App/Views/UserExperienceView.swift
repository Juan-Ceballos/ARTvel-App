//
//  UserExperienceView.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/29/20.
//

import Foundation
import SnapKit

class UserExperienceView: UIView {
    
    public lazy var experiencePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    public lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        return button
    }()
    
    public lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        return button
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
        configureExperiencePickerViewConstraints()
        configureConfirmButtonConstraints()
        configureCancelButtonConstraints()
    }
    
    private func configureExperiencePickerViewConstraints() {
        addSubview(experiencePickerView)
        experiencePickerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    private func configureConfirmButtonConstraints() {
        addSubview(confirmButton)
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(experiencePickerView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureCancelButtonConstraints() {
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmButton.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
}
