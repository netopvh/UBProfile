//
//  USE_TextField.swift
//  UBProfile
//
//  Created by Usemobile on 04/04/19.
//

import Foundation

protocol USE_TextFieldDelegate {
    func textDidChange(_ textField: USE_TextField, text: String?)
    func textFieldShouldReturn(_ textField: USE_TextField, text: String?)
}

class USE_TextField: UIView {
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.font = self.settings.titleFont
        label.textColor = self.settings.titleColor
        self.addSubview(label)
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = self.settings.textFont
        textField.minimumFontSize = 18
        textField.adjustsFontSizeToFitWidth = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = self.returnKeyType
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        self.addSubview(textField)
        return textField
    }()
    
    lazy var btnSecurity: UIButton = {
        let button = UIButton()
        let buttonImage = self.settings.securityEnabledImage ?? UIImage.getFrom(customClass: USE_TextField.self, nameResource: "eye")
        button.setImage(buttonImage, for: .normal)
        let insets: CGFloat = 7
        button.imageEdgeInsets = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
        button.addTarget(self, action: #selector(btnSecutiryPressed), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = self.settings.mainColor
        self.addSubview(view)
        return view
    }()
    
    public var inputMask: String = "" {
        didSet {
            self.updateText()
        }
    }
    
    open var allowWhiteSpaces: Bool = true
    
    var placeholder: String = "" {
        didSet {
            self.textField.setPlaceholderFont(self.placeholder, self.settings.placeholderFont, self.settings.placeholderColor)
        }
    }
    
    var type: ProfileCellTypes {
        didSet {
            self.fillModel()
        }
    }
    var settings: TextFieldSettings
    
    var delegate: USE_TextFieldDelegate?
    var text: String? {
        didSet {
            self.delegate?.textDidChange(self, text: self.text)
        }
    }
    var formattedText: String? {
        didSet {
            self.textField.text = self.formattedText
            if let text = self.formattedText {
                self.text = self.clearFormatCoponents(text)
            }
        }
    }
    
    var returnKeyType: UIReturnKeyType = .done {
        didSet {
            self.textField.returnKeyType = self.returnKeyType
        }
    }
    
    var selectedColor: UIColor = .orange {
        didSet {
            self.borderView.backgroundColor = self.selectedColor
        }
    }
    
    init(type: ProfileCellTypes, settings: TextFieldSettings = .default) {
        self.type = type
        self.settings = settings
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.type = .mail
        self.settings = .default
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    private func setupUI() {
        let isPassword = type == .password
        self.btnSecurity.isHidden = !isPassword
        self.lblTitle.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor)
        self.textField.anchor(top: self.lblTitle.bottomAnchor, left: self.lblTitle.leftAnchor, bottom: self.bottomAnchor, right: self.lblTitle.rightAnchor, padding: .init(top: 16, left: 16, bottom: 8, right: isPassword ? 44 : 16))
        if isPassword {
            self.btnSecurity.anchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 44, height: 44))
            self.btnSecurity.centerYAnchor.constraint(equalTo: self.textField.centerYAnchor).isActive = true
        }
        self.borderView.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, size: .init(width: 0, height: 2))
        self.fillModel()
    }
    
    private func fillModel() {
        var typeText: String = ""
        self.lblTitle.text = String.new + " " + self.type.text.lowercased()
        switch type {
        case .mail:
            self.placeholder = .placeholderEmail
            self.textField.keyboardType = .emailAddress
        case .phone:
            self.placeholder = .placeholderPhone
            self.inputMask = "(##) #####-####"
            self.textField.keyboardType = .phonePad
        case .password:
            self.textField.isSecureTextEntry = true
        default:
            break
        }
    }
    
    func beginEditing() {
        self.textField.becomeFirstResponder()
    }
    
    @objc func textDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if self.inputMask.isEmpty {
                self.text = text
            } else {
                self.text = self.clearFormatCoponents(text)
            }
        } else {
            self.text = nil
        }
    }
    
    @objc func btnSecutiryPressed() {
        self.textField.isSecureTextEntry = !self.textField.isSecureTextEntry
        let image = self.textField.isSecureTextEntry ? (self.settings.securityEnabledImage ?? UIImage.getFrom(customClass: USE_TextField.self, nameResource: "eye")) : (self.settings.securityDisabledImage ?? UIImage.getFrom(customClass: USE_TextField.self, nameResource: "eye-closed"))
        self.btnSecurity.setImage(image, for: .normal)
    }
    
    private func updateText() {
        let newString0 = self.formattedText ?? ""
        guard newString0.count <= self.inputMask.count else { return }
        let newString1 = self.clearFormatCoponents(string: newString0)
        let newString = self.getNumberFormatted(number: newString1)
        self.formattedText = newString
    }
}

extension USE_TextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.textFieldShouldReturn(self, text: self.text)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 0 && range.location == 0 && string == " " { return false }
        guard !inputMask.isEmpty else {
            if !self.allowWhiteSpaces && string == " " { return false }
            self.textDidChange(textField)
            return true
        }
        let newString0 = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        guard newString0.count <= self.inputMask.count else { return false }
        let newString1 = self.clearFormatCoponents(string: newString0)
        let newString = self.getNumberFormatted(number: newString1)
        self.setTextWithoutChangingRange(old: range, newString: newString, replacementString: string)
        return false
    }
    
}



// MARK: - String Manipulations

extension USE_TextField {
    
    private func isNumber(_ char: Character) -> Bool {
        return Int("\(char)") != nil
    }
    
    private func clearFormatCoponents(string: String) -> String {
        return self.clearFormatCoponents(string)
    }
    
    private func getNumberFormatted(number: String) -> String {
        return self.getNumberFormatted(number: number, mask: self.inputMask)
    }
    
    private func setTextWithoutChangingRange(old range: NSRange, newString: String, replacementString string: String) {
        if range.location != (self.formattedText ?? "").count,
            let oldRange = self.textField.selectedTextRange {
            let isUp = string != ""
            if range.length > 1 && !isUp {
                UIPasteboard.general.string = self.formattedText?[range]
            }
            self.formattedText = newString
            if let position = self.textField.position(from: oldRange.start, offset: isUp ? 1 : range.length > 1 ? 0 : -1) {
                self.textField.selectedTextRange = self.textField.textRange(from: position, to: position)
            } else {
                self.textField.selectedTextRange = self.textField.textRange(from: oldRange.start, to: oldRange.start)
            }
        } else {
            self.formattedText = newString
        }
    }
    
    @objc func cancelAction() {
        resignFirstResponder()
    }
    
    func clearFormatCoponents(_ string: String) -> String {
        var numbers = ""
        string.compactMap({ Int(String($0)) }).forEach({ numbers.append("\($0)") })
        return numbers
    }
    
    func getNumberFormatted(number: String, mask: String) -> String {
        var returnText = ""
        var i = 0
        let maskArray = Array(mask)
        for char in number {
            let currCharMask = maskArray[i]
            if currCharMask == "#" {
                returnText.append(char)
            } else {
                returnText.append("\(currCharMask)")
                i += 1
                var found = false
                for j in i..<maskArray.count {
                    if !found {
                        let mask = maskArray[j]
                        if mask == "#" {
                            returnText.append("\(char)")
                            found = true
                        } else {
                            returnText.append("\(mask)")
                            i += 1
                        }
                    }
                }
            }
            i += 1
        }
        return returnText
    }
    
}
