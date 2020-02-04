//
//  EditProfileView.swift
//  UBProfile
//
//  Created by Usemobile on 03/04/19.
//

import Foundation
import TPKeyboardAvoiding

protocol EditProfileViewDelegate {
    func saveSuccess(_ editPasswordView: EditProfileView, newValue: String, model: ProfileCellTypes)
    func saveFailure(_ editPasswordView: EditProfileView, errorMessage: String)
}

class EditProfileView: UIView {
    
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
    
    lazy var btnSave: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.save, for: .normal)
        button.titleLabel?.font = self.settings.saveFont
        button.enabledBackgroundColor = self.settings.saveEnabledColor
        button.disabledBackgroundColor = self.settings.saveDisabledColor
        button.setTitleColor(self.settings.saveTitleColor, for: .normal)
        button.cornerRadius = 27
        button.isEnabled = false
        button.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        self.contentView.addSubview(button)
        return button
    }()
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.textColor = self.settings.titleColor
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var lblCurrentTitle: UILabel = {
        let label = UILabel()
        label.font = self.settings.currentTitleFont
        label.textColor = self.settings.currentTitleColor
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var lblCurrentText: UILabel = {
        let label = UILabel()
        label.font = self.settings.currentTextFont
        label.textColor = self.settings.currentTextColor
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var textField: USE_TextField = {
        let textField = USE_TextField(type: self.type ?? .mail, settings: self.textFieldSettings)
        textField.delegate = self
        self.contentView.addSubview(textField)
        return textField
    }()
    
    var type: ProfileCellTypes? {
        didSet {
            self.fillModel()
        }
    }
    
    var model: ProfileViewModel? {
        didSet {
            self.fillModel()
        }
    }
    var settings: EditProfileSettings
    var textFieldSettings: TextFieldSettings
    
    var delegate: EditProfileViewDelegate?
    var text: String? {
        didSet {
            self.btnSave.isEnabled = self.text == nil ? false : !(self.text!.isEmpty)
            if let _text = self.text, _text.count == 11, self.type == .phone {
                self.endEditing(false)
            }
        }
    }
    
    init(model: ProfileViewModel?, type: ProfileCellTypes?, settings: ProfileSettings = .default) {
        self.model = model
        self.type = type
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
        self.lblCurrentTitle.anchor(top: self.lblTitle.bottomAnchor, left: self.lblTitle.leftAnchor, bottom: nil, right: self.lblTitle.rightAnchor, padding: .init(top: 40.dynamicCGFloat, left: 2, bottom: 0, right: 2))
        self.lblCurrentText.anchor(top: self.lblCurrentTitle.bottomAnchor, left: self.lblCurrentTitle.leftAnchor, bottom: nil, right: self.lblCurrentTitle.rightAnchor, padding: .init(top: 14.dynamicCGFloat, left: 0, bottom: 0, right: 0))
        self.textField.anchor(top: self.lblCurrentText.bottomAnchor, left: self.lblCurrentText.leftAnchor, bottom: nil, right: self.lblCurrentText.rightAnchor, padding: .init(top: 40.dynamicCGFloat, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 85.dynamicCGFloat))
        self.setupBtnSaveConst()
        self.fillModel()
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
    
    private func fillModel() {
        guard let _model = self.model, let _type = self.type else { return }
        var typeText: String = _type.text
        switch currentLanguage {
        case .en:
            self.lblCurrentTitle.text = String.current.capitalized + " " + typeText
        case .pt:
            self.lblCurrentTitle.text = typeText + " " + .current
        case .es:
            self.lblCurrentText.text = typeText + "" + .current
        }
        switch _type {
        case .mail:
            self.lblCurrentText.text = _model.email
        case .phone:
            self.lblCurrentText.text = _model.phone
        default:
            break
        }
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: .edit + " ", attributes: [NSAttributedString.Key.font: self.settings.titleFirstFont,
                                                                                 NSAttributedString.Key.foregroundColor: self.settings.titleColor]))
        attributedText.append(NSAttributedString(string: typeText, attributes: [NSAttributedString.Key.font: self.settings.titleSecondFont,
                                                                                 NSAttributedString.Key.foregroundColor: self.settings.titleColor]))
        self.lblTitle.attributedText = attributedText
    }
    
    func checkContents() -> Bool {
        guard let _type = self.type, let _text = self.text else { return false }
        switch _type {
        case .mail:
            guard _text.isValidEmail else {
                self.delegate?.saveFailure(self, errorMessage: String.email + .invalid)
                return false
            }
        case .phone:
            guard _text.count == 11 else {
                self.delegate?.saveFailure(self, errorMessage: String.phone + .invalid)
                return false
            }
        default:
            break
        }
        return true
    }
    
    @objc func savePressed() {
        self.endEditing(false)
        guard self.checkContents() else { return }
        guard let _type = self.type, let _text = self.text else { return }
        self.delegate?.saveSuccess(self, newValue: _text, model: _type)
    }
    
    func playProgress() {
        self.btnSave.startAnimation()
    }
    
    func stopProgress(failure: Bool = false) {
        self.btnSave.stopAnimation(animationStyle: failure ? .shake : .normal)
    }
}

extension EditProfileView: USE_TextFieldDelegate {
    func textFieldShouldReturn(_ textField: USE_TextField, text: String?) {
        self.savePressed()
    }
    func textDidChange(_ textField: USE_TextField, text: String?) {
        self.text = text
    }
}
