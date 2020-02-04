//
//  HeaderView.swift
//  UBProfile
//
//  Created by Usemobile on 02/04/19.
//

import Foundation
import UIKit
import HCSStarRatingView

protocol HeaderViewDelegate {
    func editIamgePressed(_ headerView: HeaderView)
}

class HeaderView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = self.settings.nameColor
        label.font = self.settings.nameFont
        self.addSubview(label)
        return label
    }()
    
    lazy var ratingView: HCSStarRatingView = {
        let view = HCSStarRatingView()
        view.backgroundColor = .clear
        view.filledStarImage = self.settings.starFilledImage
        view.emptyStarImage = self.settings.starEmptyImage
        view.emptyStarColor = self.settings.starEmptyColor
        view.tintColor = self.settings.starFilledColor
        view.starBorderColor = .clear
        view.value = self.model.rate
        view.spacing = 2
        view.allowsHalfStars = true
        view.isUserInteractionEnabled = false
        self.addSubview(view)
        return view
    }()
    
    lazy var viewEdit: UIView = {
        let view = UIView()
        view.backgroundColor = self.settings.editBackgroundColor
        view.layer.cornerRadius = 14
        self.addSubview(view)
        return view
    }()
    
    lazy var btnEdit: UIButton = {
        let button = UIButton()
        let insets: CGFloat = 17
        button.imageEdgeInsets = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
        button.backgroundColor = .clear
        button.setImage((self.settings.editImage ?? UIImage.getFrom(customClass: HeaderView.self, nameResource: "pencil"))?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = self.settings.editTintColor
        button.addTarget(self, action: #selector(self.btnEditPressed), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    var path: UIBezierPath!
    var delegate: HeaderViewDelegate?
    var model: ProfileViewModel {
        didSet {
            self.setupModel()
        }
    }
    var settings: ProfileSettings
    
    init(model: ProfileViewModel, settings: ProfileSettings = .default) {
        self.model = model
        self.settings = settings
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.setupUI()
        self.setupModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.model = ProfileViewModel(name: "", rate: 0, profileImage: "", email: "", phone: "", cpf: "")
        self.settings = .default
        super.init(coder: aDecoder)
        self.backgroundColor = .white
        self.setupUI()
        self.setupModel()
    }
    
    override func draw(_ rect: CGRect) {
        self.createShape()
        
        self.settings.headerBGColor.setFill()
        path.fill()
    }
    
    fileprivate func setupUI() {
        let dynamicSize: CGFloat = (UIScreen.main.bounds.height * 120 / 667)
        let size = dynamicSize > 120 ? 120 : dynamicSize
        
        self.imageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, padding: .init(top: 60, left: 32, bottom: 0, right: 0), size: .init(width: size, height: size))
        self.imageView.layer.cornerRadius = size/2
        self.label.anchor(top: nil, left: self.imageView.rightAnchor, bottom: self.imageView.centerYAnchor, right: self.rightAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 32))
        self.ratingView.anchor(top: self.label.bottomAnchor, left: self.label.leftAnchor, bottom: nil, right: nil, size: .init(width: 68, height: 12))
        
        self.btnEdit.anchor(top: nil, left: self.imageView.leftAnchor, bottom: self.imageView.bottomAnchor, right: nil, padding: .init(top: 0, left: -7, bottom: -5, right: 0), size: .init(width: 50, height: 50))
        self.viewEdit.anchor(top: self.btnEdit.topAnchor, left: self.btnEdit.leftAnchor, bottom: nil, right: nil, padding: .init(top: 11, left: 11, bottom: 0, right: 0), size: .init(width: 28, height: 28))
        self.bringSubviewToFront(self.btnEdit)
        
    }
    
    func setupModel() {
        self.label.text = self.model.name
        self.castProfile()
    }
    
    func createShape() {
        // Initialize the path.
        path = self.getPath(for: 450)
        path.close()
    }
    
    func getPath(for radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        let circleBeginY = self.frame.size.height * 220 / 250
        let sliceRadians = self.getSliceRadians(for: radius)
        let beginRadians = self.getBeginRadians(for: radius)
        path.addLine(to: CGPoint(x: 0.0, y: circleBeginY))
        path.addArc(withCenter: CGPoint(x: self.frame.size.width/2, y: -(radius - circleBeginY)), radius: radius, startAngle: (beginRadians + sliceRadians).toRadians(), endAngle: beginRadians.toRadians(), clockwise: false)
        path.addLine(to: CGPoint(x: self.frame.size.width, y: circleBeginY))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0))
        
        return path
    }
    
    func getSliceRadians(for radius: CGFloat) -> CGFloat {
        return 90 * UIScreen.main.bounds.width / (CGFloat(sqrt(2)) * radius)
    }
    
    func getBeginRadians(for radius: CGFloat) -> CGFloat {
        let sum: CGFloat = (180 - self.getSliceRadians(for: radius))/2
        return sum
    }
    
    @objc func btnEditPressed() {
        self.delegate?.editIamgePressed(self)
    }
    
    func castProfile() {
        let placeholderSettings = (self.model.gender == .man ? self.settings.placeholderManImage : self.settings.placeholderWomanImage)
        let placeholder = UIImage.getFrom(customClass: HeaderView.self, nameResource: "placeholder-" + self.model.gender.rawValue)
        self.imageView.cast(urlStr: self.model.profileImage, placeholder: placeholderSettings ?? placeholder)
    }
    
    func setProfileImage(_ image: UIImage) {
        self.imageView.image = image
    }
    
}

