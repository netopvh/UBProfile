//
//  Extensions.swift
//  UBProfile
//
//  Created by Usemobile on 02/04/19.
//

import Foundation
import UIKit

extension UIImage {
    
    class func getFrom(customClass: AnyClass, nameResource: String) -> UIImage? {
        let frameWorkBundle = Bundle(for: customClass)
        if let bundleURL = frameWorkBundle.resourceURL?.appendingPathComponent("UBProfile.bundle") , let resourceBundle = Bundle(url: bundleURL) {
            return UIImage(named: nameResource, in: resourceBundle, compatibleWith: nil)
        }
        return nil
    }
}

extension UIView {
    func fillSuperview(with padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        self.anchor(top: self.superview?.topAnchor, left: self.superview?.leftAnchor, bottom: self.superview?.bottomAnchor, right: self.superview?.rightAnchor, padding: padding, size: size)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
            
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
            
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
}


extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}

extension String {
    
    subscript(_ range: NSRange) -> String? {
        var substring = ""
        guard range.location + range.length - 1 < self.count else { return nil }
        let string = Array(self)
        for i in range.location..<(range.location + range.length) {
            substring.append(string[i])
        }
        return substring
    }
    
    subscript(value: CountableClosedRange<Int>) -> String {
        get {
            return "\(self[index(at: value.lowerBound)...index(at: value.upperBound)])"
        }
    }
    
    subscript(value: CountableRange<Int>) -> String {
        get {
            return String(self[index(at: value.lowerBound)..<index(at: value.upperBound)])
        }
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> String {
        get {
            return String(self[..<index(at: value.upperBound)])
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> String {
        get {
            return String(self[...index(at: value.upperBound)])
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> String {
        get {
            return String(self[index(at: value.lowerBound)...])
        }
    }
    
    func index(at offset: Int) -> String.Index {
        return index(startIndex, offsetBy: offset)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = self.range(of: emailRegEx, options: .regularExpression)
        let result = range != nil ? true : false
        return result
    }
    
    func formatted(_ format: String) -> String {
        var formattedText = ""
        let formatArray = Array(format)
        var indexIncrease = 0
        
        for (index, char) in self.enumerated() {
            let increasedIndex = index + indexIncrease
            if formatArray.count > increasedIndex {
                while (formatArray.count > (index + indexIncrease)) && formatArray[(index + indexIncrease)] != "#" {
                    formattedText.append(formatArray[(index + indexIncrease)])
                    indexIncrease += 1
                }
                if (formatArray.count > (index + indexIncrease)) && formatArray[(index + indexIncrease)] == "#" {
                    formattedText.append(char)
                }
            } else {
               break
            }
        }
        return formattedText
        
    }
}

extension UIImageView {
    
    func cast(urlStr: String, placeholder: UIImage? = nil, completion: ((UIImage?, String?) -> Void)? = nil) {
        if let data = UserDefaults.standard.object(forKey: urlStr) as? Data, let image = UIImage(data: data) {
            completion?(image, nil)
            self.image = image
        } else {
            self.image = placeholder
            guard let url = URL.init(string: urlStr) else {
                completion?(nil, .invalidURL)
                return
            }
            URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(data, forKey: urlStr)
                        let image: UIImage? = UIImage(data: data)
                        completion?(image, nil)
                        self.image = image ?? placeholder
                    }
                } else if let error = error {
                    completion?(nil, error.localizedDescription)
                } else {
                    completion?(nil, .imageCastFail)
                }
                }.resume()
        }
    }
}

extension UITextField {
    
    func setPlaceholderFont(_ text: String, _ font: UIFont, _ color: UIColor) {
        let attributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: font
        ]
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
    
}

extension Int {
    var dynamic: Int {
        let aux: Int = self * Int(UIScreen.main.bounds.height) / 667
        return aux > self ? self : aux
    }
    var dynamicCGFloat: CGFloat {
        return CGFloat(self).dynamic
    }
}

extension Double {
    var dynamic: Double {
        return Double(self.dynamicCGFloat)
    }
    var dynamicCGFloat: CGFloat {
        return CGFloat(self).dynamic
    }
}

extension CGFloat {
    var dynamic: CGFloat {
        let aux: CGFloat = self * UIScreen.main.bounds.height / 667
        return aux > self ? self : aux
    }
}

