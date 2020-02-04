//
//  ProfileCell.swift
//  UBProfile
//
//  Created by Usemobile on 02/04/19.
//

import Foundation

public enum ProfileCellTypes: String, CaseIterable {
    case mail = "email"
    case phone = "celular"
    case password = "senha"
    case doc = "cpf"
    case cashback = "cashback"
    
    var text: String {
        switch self {
        case .mail:
            return .email
        case .phone:
            return .phone
        case .password:
            return .password
        case .doc:
            return .cpf
        case .cashback:
            return .cashback
        }
    }
}
class ProfileCell: UITableViewCell {
    
    lazy var viewBorder: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var lblText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        self.contentView.addSubview(label)
        return label
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
    
    var settings: ProfileCellSettings? {
        didSet {
            self.setupSettings()
        }
    }
    
    lazy var viewArrow: ArrowView = {
        let view = ArrowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private var arrowHeight = NSLayoutConstraint()
    private var arrowWidth = NSLayoutConstraint()
    
    func setup() {
        self.contentView.backgroundColor = .white
        self.selectionStyle = .none
        self.viewBorder.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, size: .init(width: 0, height: 1))
        self.lblTitle.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, padding: .init(top: 16, left: 32, bottom: 0, right: 60))
        self.lblText.anchor(top: self.lblTitle.bottomAnchor, left: self.lblTitle.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.viewArrow.leftAnchor, padding: .init(top: 4, left: 0, bottom: 16, right: 0))
        self.viewArrow.anchor(top: nil, left: nil, bottom: nil, right: self.contentView.rightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 32))
        self.arrowHeight = self.viewArrow.heightAnchor.constraint(equalToConstant: 22)
        self.arrowHeight.priority = .defaultLow
        self.arrowWidth = self.viewArrow.widthAnchor.constraint(equalToConstant: 15)
        self.arrowWidth.priority = .defaultLow
        let arrowHeightBig = self.viewArrow.heightAnchor.constraint(equalToConstant: 0)
        arrowHeightBig.priority = UILayoutPriority(750)
        let arrowWidthBig = self.viewArrow.widthAnchor.constraint(equalToConstant: 0)
        arrowWidthBig.priority = UILayoutPriority(750)
        self.addConstraints([
            self.arrowHeight,
            self.arrowWidth,
            arrowHeightBig,
            arrowWidthBig
            ])
        self.viewArrow.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    func setSelection(selected: Bool) {
        guard self.type != .doc && self.type != .cashback else { return }
        let textColor: UIColor = self.settings?.textColor ?? #colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1)
        self.contentView.backgroundColor = selected ? (self.settings?.tintColor ?? .orange) : .white
        self.lblTitle.textColor = selected ? .white : textColor
        self.lblText.textColor = selected ? .white : textColor
        self.viewArrow.color = selected ? .white : textColor
    }
    
    func fillModel() {
        guard let model = self.model, let type = self.type else { return }
        self.lblTitle.text = type.text
        
        let arrowHidden: (Bool) = (type == .doc || type == .cashback)
        self.arrowHeight.priority = UILayoutPriority(rawValue: arrowHidden ? 250 : 999)
        self.arrowWidth.priority = UILayoutPriority(rawValue: arrowHidden ? 250 : 999)
        self.viewArrow.isHidden = arrowHidden
        switch type {
        case .mail:
            self.lblText.text = model.email
        case .phone:
            self.lblText.text = model.phone
        case .password:
            self.lblText.text = "********"
        case .doc:
            self.lblText.text = model.cpf
        case .cashback:
            self.lblText.text = model.cashback
        }
        self.layoutIfNeeded()
    }
    
    func setupSettings() {
        guard let _settings = self.settings else { return }
        self.viewBorder.backgroundColor = _settings.borderColor
        self.viewArrow.color = _settings.arrowColor
        self.lblTitle.font = _settings.titleFont
        self.lblText.font = _settings.textFont
        self.lblTitle.textColor = _settings.textColor
        self.lblText.textColor = _settings.textColor
    }
    
}
