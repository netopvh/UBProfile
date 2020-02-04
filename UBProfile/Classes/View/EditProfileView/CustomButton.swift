//
//  CustomButton.swift
//  UBProfile
//
//  Created by Usemobile on 03/04/19.
//

import Foundation

import TransitionButton

class CustomButton: TransitionButton {
    
    var enabledBackgroundColor: UIColor = .orange {
        didSet {
            self.backgroundColor = self.isEnabled ? self.enabledBackgroundColor : self.disabledBackgroundColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor = self.isEnabled ? self.enabledBackgroundColor : self.disabledBackgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        self.backgroundColor = self.enabledBackgroundColor
        self.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.highlighted)
    }
    
}

