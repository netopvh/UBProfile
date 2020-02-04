//
//  Settings.swift
//  UBProfile
//
//  Created by Usemobile on 08/04/19.
//

import Foundation

public enum ProfileLanguage: String {
    case en = "en-US"
    case pt = "pt-BR"
    case es = "es-BO"
}

var currentLanguage: ProfileLanguage = .pt

public class ProfileSettings {
    public var language: ProfileLanguage = .pt {
        didSet {
            currentLanguage = language
        }
    }

    public var headerBGColor: UIColor
    public var mainColor: UIColor
    public var nameColor: UIColor
    public var starFilledColor: UIColor
    public var starEmptyColor: UIColor
    public var editTintColor: UIColor
    public var editBackgroundColor: UIColor
    
    public var nameFont: UIFont
    
    public var closeImage: UIImage?
    public var placeholderManImage: UIImage?
    public var placeholderWomanImage: UIImage?
    public var editImage: UIImage?
    public var starFilledImage: UIImage?
    public var starEmptyImage: UIImage?
    
    public var profileCellSettings: ProfileCellSettings
    public var editProfileSettings: EditProfileSettings
    public var textFieldSettings: TextFieldSettings
    
    public static var `default`: ProfileSettings {
        return ProfileSettings(headerBGColor: .orange, mainColor: .orange, nameFont: .boldSystemFont(ofSize: 22))
    }
    
    public init(headerBGColor: UIColor, mainColor: UIColor, nameColor: UIColor = .white, starFilledColor: UIColor = .white, starEmptyColor: UIColor = UIColor.white.withAlphaComponent(0.2), editTintColor: UIColor = .white, editBackgroundColor: UIColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1), nameFont: UIFont, closeImage: UIImage? = nil, placeholderManImage: UIImage? = nil, placeholderWomanImage: UIImage? = nil, editImage: UIImage? = nil, starFilledImage: UIImage? = nil, starEmptyImage: UIImage? = nil, profileCellSettings: ProfileCellSettings? = nil, editProfileSettings: EditProfileSettings? = nil, textFieldSettings: TextFieldSettings? = nil) {
        self.headerBGColor = headerBGColor
        self.mainColor = mainColor
        self.nameColor = nameColor
        self.starFilledColor = starFilledColor
        self.starEmptyColor = starEmptyColor
        self.editTintColor = editTintColor
        self.editBackgroundColor = editBackgroundColor
        self.nameFont = nameFont
        self.closeImage = closeImage
        self.placeholderManImage = placeholderManImage
        self.placeholderWomanImage = placeholderWomanImage
        self.editImage = editImage
        self.starFilledImage = starFilledImage
        self.starEmptyImage = starEmptyImage
        self.profileCellSettings = profileCellSettings ?? ProfileCellSettings(tintColor: mainColor, titleFont: .systemFont(ofSize: 14), textFont: .systemFont(ofSize: 22))
        self.editProfileSettings = editProfileSettings ?? EditProfileSettings(saveEnabledColor: mainColor, titleFirstFont: .systemFont(ofSize: 40, weight: .light), titleSecondFont: .systemFont(ofSize: 40, weight: .bold), currentTitleFont: .systemFont(ofSize: 24), currentTextFont: .systemFont(ofSize: 25), saveFont: .systemFont(ofSize: 20, weight: .black))
        self.textFieldSettings = textFieldSettings ?? TextFieldSettings(mainColor: mainColor, titleFont: .systemFont(ofSize: 24), textFont: .systemFont(ofSize: 30), placeholderFont: .italicSystemFont(ofSize: 30))
        
    }
}

public class ProfileCellSettings {
    
    public var tintColor: UIColor
    public var arrowColor: UIColor
    public var borderColor: UIColor
    public var textColor: UIColor
    
    public var titleFont: UIFont
    public var textFont: UIFont
    
    public static var `default`: ProfileCellSettings {
        return ProfileCellSettings(tintColor: .orange, titleFont: UIFont.systemFont(ofSize: 14), textFont: UIFont.systemFont(ofSize: 22))
    }
    
    public init(tintColor: UIColor, arrowColor: UIColor = #colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1), borderColor: UIColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), textColor: UIColor = #colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1), titleFont: UIFont, textFont: UIFont) {
        self.tintColor = tintColor
        self.arrowColor = arrowColor
        self.borderColor = borderColor
        self.textColor = textColor
        self.titleFont = titleFont
        self.textFont = textFont
    }
}

public class EditProfileSettings {
    
    public var titleColor: UIColor
    public var currentTitleColor: UIColor
    public var currentTextColor: UIColor
    public var saveEnabledColor: UIColor
    public var saveDisabledColor: UIColor
    public var saveTitleColor: UIColor
    
    public var titleFirstFont: UIFont
    public var titleSecondFont: UIFont
    public var currentTitleFont: UIFont
    public var currentTextFont: UIFont
    public var saveFont: UIFont
    
    public static var `default`: EditProfileSettings {
        return EditProfileSettings(saveEnabledColor: .orange, titleFirstFont: .systemFont(ofSize: 40, weight: .light), titleSecondFont: .systemFont(ofSize: 40, weight: .bold), currentTitleFont: .systemFont(ofSize: 24), currentTextFont: .systemFont(ofSize: 25), saveFont: .systemFont(ofSize: 20, weight: .black))
    }
    
    public init(titleColor: UIColor = .black, currentTitleColor: UIColor = #colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1), currentTextColor: UIColor = .black, saveEnabledColor: UIColor, saveDisabledColor: UIColor = #colorLiteral(red: 0.8666666667, green: 0.8784313725, blue: 0.8784313725, alpha: 1), saveTitleColor: UIColor = .white, titleFirstFont: UIFont, titleSecondFont: UIFont, currentTitleFont: UIFont, currentTextFont: UIFont, saveFont: UIFont) {
        self.titleColor = titleColor
        self.currentTitleColor = currentTitleColor
        self.currentTextColor = currentTextColor
        self.saveEnabledColor = saveEnabledColor
        self.saveDisabledColor = saveDisabledColor
        self.saveTitleColor = saveTitleColor
        self.titleFirstFont = titleFirstFont
        self.titleSecondFont = titleSecondFont
        self.currentTitleFont = currentTitleFont
        self.currentTextFont = currentTextFont
        self.saveFont = saveFont
    }
}

public class TextFieldSettings {
    
    public var mainColor: UIColor
    public var titleColor: UIColor
    public var textColor: UIColor
    public var placeholderColor: UIColor
    
    public var titleFont: UIFont
    public var textFont: UIFont
    public var placeholderFont: UIFont
    
    public var securityEnabledImage: UIImage?
    public var securityDisabledImage: UIImage?
    
    public static var `default`: TextFieldSettings {
        return TextFieldSettings(mainColor: .orange, titleFont: .systemFont(ofSize: 24), textFont: .systemFont(ofSize: 30), placeholderFont: .italicSystemFont(ofSize: 30))
    }
    
    public init(mainColor: UIColor, titleColor: UIColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), textColor: UIColor = .black, placeholderColor: UIColor = #colorLiteral(red: 0.8666666667, green: 0.8784313725, blue: 0.8784313725, alpha: 1), titleFont: UIFont, textFont: UIFont, placeholderFont: UIFont, securityEnabledImage: UIImage? = nil, securityDisabledImage: UIImage? = nil) {
        self.mainColor = mainColor
        self.titleColor = titleColor
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.titleFont = titleFont
        self.textFont = textFont
        self.placeholderFont = placeholderFont
        self.securityEnabledImage = securityEnabledImage
        self.securityDisabledImage = securityDisabledImage
    }
    
}
