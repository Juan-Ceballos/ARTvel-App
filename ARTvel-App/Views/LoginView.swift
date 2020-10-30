//
//  LoginView.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/29/20.
//

import Foundation
import SnapKit

class LoginView: UIView {
    
    override func layoutSubviews() {
        createAccountButton.clipsToBounds = true
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.cornerRadius = createAccountButton.frame.size.height / 2
        createAccountButton.layer.borderColor = UIColor.black.cgColor
    }
    
    public var appTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "ARTvel"
        label.textAlignment = .center
        label.font = UIFont(name: "copperplate", size: 55)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(red: 166/255, green: 125/255, blue: 39/255, alpha: 1)
        return label
    }()
    
    public var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Username(email)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.borderStyle = .none
        textField.textColor = .white
        let ca = CALayer()
        ca.frame = CGRect(x: 0, y: textField.frame.height + 22, width: UIScreen.main.bounds.size.width - 44, height: 10)
        ca.backgroundColor = UIColor(red: 166/255, green: 125/255, blue: 39/255, alpha: 0.5).cgColor
        ca.cornerRadius = ca.frame.size.width / 200
        textField.layer.addSublayer(ca)
        return textField
    }()
    
    public var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.borderStyle = .none
        textField.textColor = .white
        let ca = CALayer()
        ca.frame = CGRect(x: 0, y: textField.frame.height + 22, width: UIScreen.main.bounds.size.width - 44, height: 10)
        ca.backgroundColor = UIColor(red: 166/255, green: 125/255, blue: 39/255, alpha: 0.5).cgColor
        ca.cornerRadius = ca.frame.size.width / 200
        textField.layer.addSublayer(ca)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    public var createAccountButton: UIButton = {
        let screenWidth = UIScreen.main.bounds.size.width
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.systemBackground, for: .normal)
        button.setTitle("Create My Account", for: .normal)
        button.backgroundColor = UIColor(red: 201/255, green: 214/255, blue: 223/255, alpha: 0.2)
        return button
    }()
    
    public var signedUpUserButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.systemBackground, for: .normal)
        button.setTitle("Current User Sign-in", for: .normal)
        button.backgroundColor = UIColor(red: 166/255, green: 125/255, blue: 39/255, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
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
        setupAppTitleLabelConstraints()
        setupUsernameTextFieldConstraints()
        setupPasswordTextFieldConstraints()
        setupLoginButtonConstraints()
        setupSignedUpUserButton()
    }
    
    private func setupAppTitleLabelConstraints()    {
        addSubview(appTitleLabel)
        appTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(44)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func setupUsernameTextFieldConstraints()    {
        addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-88)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-22)
        }
    }
    
    private func setupPasswordTextFieldConstraints()    {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-22)
        }
    }
    
    private func setupLoginButtonConstraints()  {
        addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(55)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(createAccountButton.snp.width).multipliedBy(0.2)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupSignedUpUserButton()  {
        addSubview(signedUpUserButton)
        signedUpUserButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.075)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}
