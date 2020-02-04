//
//  Strings.swift
//  UBHistory
//
//  Created by Usemobile on 27/03/19.
//

import Foundation

extension String {
    
    static var email: String {
        switch currentLanguage {
        case .en:
            return "Email"
        case .pt:
            return "E-mail"
        case .es:
            return "Email"
        }
    }
    
    static var phone: String {
        switch currentLanguage {
        case .en:
            return "Phone"
        case .pt:
            return "Celular"
        case .es:
            return "Móvil"
        }
    }
    
    static var password: String {
        switch currentLanguage {
        case .en:
            return "Password"
        case .pt:
            return "Senha"
        case .es:
            return "Contrasña"
        }
    }
    
    static var cpf: String {
        switch currentLanguage {
        case .pt:
            return "CPF"
        case .en:
            return "CPF"
        case .es:
            return "CI"
        }
    }
    
    static var new: String {
        switch currentLanguage {
        case .en:
            return "New"
        case .pt:
            return "Novo"
        case .es:
            return "Nuevo"
        }
    }
    
    static var placeholderEmail: String {
        switch currentLanguage {
        case .en:
            return "Ex. name@email.com"
        case .pt:
            return "Ex. nome@email.com"
        case .es:
            return "Ex. nombre@email.com"
        }
    }
    
    static var placeholderPhone: String {
        switch currentLanguage {
        case .pt:
            return "Ex. 31 987654321"
        case .en:
            return "Ex. 31 987654321"
        case .es:
            return "Ex. 876-432"
        }
    }
    
    static var fillYour: String {
        switch currentLanguage {
        case .en:
            return "Fill your\n"
        case .pt:
            return "Preencha a sua\n"
        case .es:
            return "Complete su\n"
        }
    }
    
    static var newPassword: String {
        switch currentLanguage {
        case .en:
            return "New password"
        case .pt:
            return "Nova senha"
            //            return .password + " " + String.new.capitalized
        case .es:
            return "Nueva contraseña"
        }
    }
    
    static var current: String {
        switch currentLanguage {
        case .en:
            return "current"
        case .pt:
            return "atual"
        case .es:
            return "actual"
        }
    }
    
    static var currentPassword: String {
        switch currentLanguage {
        case .en:
            return String.current.capitalized + " " + .password
        case .pt:
            return String.password.capitalized + " " + .current
        case .es:
            return String.password.capitalized + "" + .current
        }
    }
    
    static var save: String {
        switch currentLanguage {
        case .en:
            return "Save"
        case .pt:
            return "Salvar"
        case .es:
            return "Guardar"
        }
    }
    
    static var currentPasswordMinChar: String {
        switch currentLanguage {
        case .en:
            return "The current password must contains at least"
        case .pt:
            return "A senha atual deve conter ao menos"
        case .es:
            return "La nueva contraseña debe contener al menos"
        }
    }
    
    static var digits: String {
        switch currentLanguage {
        case .en:
            return "digits"
        case .pt:
            return "dígitos"
        case .es:
            return "dígitos"
        }
    }
    
    static var newPasswordMinChar: String {
        switch currentLanguage {
        case .en:
            return "The new password must contains at least"
        case .pt:
            return "A senha nova deve conter ao menos"
        case .es:
            return "La nueva contraseña debe contener al menos"
        }
    }
    
    static var edit: String {
        switch currentLanguage {
        case .en:
            return "Edit"
        case .pt:
            return "Editar"
        case .es:
            return "Editar"
        }
    }
    
    static var invalid: String {
        switch currentLanguage {
        case .en:
            return " invalid"
        case .pt:
            return " inválido"
        case .es:
            return " inválido"
        }
    }
    
    static var selectImage: String {
        switch currentLanguage {
        case .en:
            return "Select an image"
        case .pt:
            return "Selecionar uma foto"
        case .es:
            return "Selecciona una foto"
        }
    }
    
    static var takePicture: String {
        switch currentLanguage {
        case .en:
            return "Take picture"
        case .pt:
            return "Tirar foto"
        case .es:
            return "Tomar la foto"
        }
    }
    
    static var chooseLibrary: String {
        switch currentLanguage {
        case .en:
            return "Choose from library"
        case .pt:
            return "Escolher da biblioteca"
        case .es:
            return "Elige de la biblioteca"
        }
    }
    
    static var cancel: String {
        switch currentLanguage {
        case .en:
            return "Cancel"
        case .pt:
            return "Cancelar"
        case .es:
            return "Cancelar"
        }
    }
    
    static var invalidURL: String {
        switch currentLanguage {
        case .en:
            return "Invalid URL"
        case .pt:
            return "URL inválida"
        case .es:
            return "URL inválida"
        }
    }
    
    static var imageCastFail: String {
        switch currentLanguage {
        case .en:
            return "Image cast fail"
        case .pt:
            return "Falha ao receber imagem"
        case .es:
            return "Error al recibir la imagen"
        }
    }
    
    static var cashback: String {
        switch currentLanguage {
        case .en:
            return "Cashback"
        case .pt:
            return "Cashback"
        case .es:
            return "Cashback"
        }
    }
    
    static var noCashbackAvailable: String {
        switch currentLanguage {
        case .en:
            return "You don't have any cashback available yet"
        case .pt:
            return "Você ainda não tem cashback disponível"
        case .es:
            return "Aún no tienes reembolso disponible"
        }
    }
    
//    static var model: String {
//        switch currentLanguage {
//        case .en:
//            return ""
//        case .pt:
//            return ""
//        }
//    }
}
