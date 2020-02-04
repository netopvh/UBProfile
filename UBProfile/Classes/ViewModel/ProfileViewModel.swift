//
//  ProfileViewModel.swift
//  UBProfile
//
//  Created by Usemobile on 08/04/19.
//

import Foundation

public enum Gender: String {
    case man
    case woman
}

public class ProfileViewModel {
    
    public let name: String
    public let rate: CGFloat
    public let profileImage: String
    public let email: String
    public let phone: String
    public let cpf: String
    public let gender: Gender
    public let cashback: String?
    
    public init(name: String, lastName: String? = nil, rate: Double, profileImage: String, email: String, phone: String, cpf: String, gender: String = "m", cashback: Double? = nil) {
        self.name           = name + (lastName == nil ? "" : " \(lastName!)")
        self.rate           = CGFloat(rate)
        self.profileImage   = profileImage
        self.email          = email
        self.phone          = phone.formatted("(##) #####-####")
        self.cpf            = cpf.formatted("###.###.###-##")
        
        self.gender         = gender.first == "m" ? .man : .woman
        if let cashback = cashback {
            if cashback == 0 {
                self.cashback = .noCashbackAvailable
            } else {
                let numberFormatter = NumberFormatter()
                numberFormatter.groupingSize = 3
                numberFormatter.maximumFractionDigits = 2
                numberFormatter.decimalSeparator = ","
                numberFormatter.groupingSeparator = "."
                numberFormatter.usesGroupingSeparator = true
                numberFormatter.minimumIntegerDigits = 1
                numberFormatter.minimumFractionDigits = 2
                if let formatedValue = numberFormatter.string(from: NSNumber(value: cashback)) {
                    self.cashback   = "R$ " + formatedValue
                } else {
                    self.cashback   = "R$ " + String(format: "%.2f", cashback).replacingOccurrences(of: ".", with: ",")
                }
            }
        } else {
            self.cashback   = nil
        }
    }
}
