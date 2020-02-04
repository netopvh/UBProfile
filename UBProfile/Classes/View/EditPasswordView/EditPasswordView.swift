//
//  EditPasswordView.swift
//  UBProfile
//
//  Created by Usemobile on 04/04/19.
//

import Foundation
import TPKeyboardAvoiding

protocol EditPasswordViewDelegate {
    func saveSuccess(_ editPasswordView: EditPasswordView, currentPassword: String, newPassword: String)
    func saveFailure(_ editPasswordView: EditPasswordView, errorMessage: String)
}

class EditPasswordView: UIView {
    
    lazy var scrollView: TPKeyboardAvoidingScrollView = {
        let scrollView = TPKeyboardAvoidingScrollView()
        scrollView.backgroundColor = .clear
        self.addSubview(scrollView)
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        self.scrollView.addSubview(view)
        return view
    }()
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: .fillYour, attributes: [NSAttributedString.Key.font: self.settings.titleFirstFont, NSAttributedString.Key.foregroundColor: self.settings.titleColor]))
        attributedText.append(NSAttributedString(string: .newPassword, attributes: [NSAttributedString.Key.font: self.settings.titleSecondFont, NSAttributedString.Key.foregroundColor: self.settings.titleColor]))
        label.attributedText = attributedText
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var txfCurrent: USE_TextField = {
        let textField = USE_TextField(type: .password, settings: self.textFieldSettings)
        textField.returnKeyType = .next
        textField.lblTitle.text = .currentPassword
        textField.placeholder = .currentPassword
        textField.delegate = self
        self.contentView.addSubview(textField)
        return textField
    }()
    
    lazy var txfNew: USE_TextField = {
        let textField = USE_TextField(type: .password, settings: self.textFieldSettings)
        textField.lblTitle.text = .newPassword
        textField.placeholder = .newPassword
        textField.delegate = self
        self.contentView.addSubview(textField)
        return textField
    }()
    
    lazy var btnSave: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(self.settings.saveTitleColor, for: .normal)
        button.titleLabel?.font = self.settings.saveFont
        button.enabledBackgroundColor = self.settings.saveEnabledColor
        button.disabledBackgroundColor = self.settings.saveDisabledColor
        button.setTitle(.save, for: .normal)
        button.cornerRadius = 27
        button.isEnabled = false
        button.addTarget(self, action: #selector(self.savePressed), for: .touchUpInside)
        self.contentView.addSubview(button)
        return button
    }()
    
    var delegate: EditPasswordViewDelegate?
    
    var currentPassword: String? {
        didSet {
            self.setButtonState()
        }
    }
    var newPassword: String? {
        didSet {
            self.setButtonState()
        }
    }
    
    let minPassChars = 6
    var settings: EditProfileSettings
    var textFieldSettings: TextFieldSettings
    
    init(settings: ProfileSettings = .default) {
        self.settings = settings.editProfileSettings
        self.textFieldSettings = settings.textFieldSettings
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.settings = .default
        self.textFieldSettings = .default
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.scrollView.fillSuperview()
        self.contentView.fillSuperview()
        self.addConstraints([
            self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: self.heightAnchor)
            ])
        self.lblTitle.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, padding: .init(top: 40.dynamicCGFloat, left: 16.dynamicCGFloat, bottom: 0, right: 16.dynamicCGFloat))
        self.txfCurrent.anchor(top: self.lblTitle.bottomAnchor, left: self.lblTitle.leftAnchor, bottom: nil, right: self.lblTitle.rightAnchor, padding: .init(top: 50.dynamicCGFloat, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 85.dynamicCGFloat))
        self.txfNew.anchor(top: self.txfCurrent.bottomAnchor, left: self.txfCurrent.leftAnchor, bottom: nil, right: self.txfCurrent.rightAnchor, padding: .init(top: 16.dynamicCGFloat, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 85.dynamicCGFloat))
        self.setupBtnSaveConst()
    }
    
    private func setupBtnSaveConst() {
        self.addConstraints([
            self.btnSave.heightAnchor.constraint(equalToConstant: 54),
            self.btnSave.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.btnSave.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 320/375)
            ])
        if #available(iOS 11.0, *) {
            self.btnSave.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        } else {
            self.btnSave.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -32).isActive = true
        }
    }
    
    func setButtonState() {
        if let _newPassword = self.newPassword, _newPassword.count > 0, let _currentPassword = self.currentPassword, _currentPassword.count > 0 {
            self.btnSave.isEnabled = true
        } else {
            self.btnSave.isEnabled = false
        }
    }
    
    func checkPasswords() -> Bool {
        guard let _currentPassword = self.currentPassword, _currentPassword.count >= self.minPassChars else {
            self.delegate?.saveFailure(self, errorMessage: .currentPasswordMinChar + " \(self.minPassChars) " + .digits)
            return false
        }
        guard let _newPasssword = self.newPassword, _newPasssword.count >= self.minPassChars else {
            self.delegate?.saveFailure(self, errorMessage: .newPasswordMinChar + " \(self.minPassChars) " + .digits)
            return false
        }
        return true
    }
    
    @objc func savePressed() {
        self.endEditing(false)
        guard self.checkPasswords() else { return }
        guard let _currentPassword = self.currentPassword, let _newPassword = self.newPassword else { return }
        self.delegate?.saveSuccess(self, currentPassword: _currentPassword, newPassword: _newPassword)
    }
    
    func playProgress() {
        self.btnSave.startAnimation()
    }
    
    func stopProgress(failure: Bool = false) {
        self.btnSave.stopAnimation(animationStyle: failure ? .shake : .normal)
    }
}

extension EditPasswordView: USE_TextFieldDelegate {
    func textFieldShouldReturn(_ textField: USE_TextField, text: String?) {
        switch textField {
        case self.txfCurrent:
            self.txfNew.beginEditing()
        case self.txfNew:
            self.savePressed()
        default:
            break
        }
    }
    func textDidChange(_ textField: USE_TextField, text: String?) {
        switch textField {
        case self.txfCurrent:
            self.currentPassword = text
        case self.txfNew:
            self.newPassword = text
        default:
            break
        }
    }
}
