//
//  ProfileView.swift
//  UBProfile
//
//  Created by Usemobile on 02/04/19.
//

import Foundation

protocol ProfileViewDelegate {
    func editImage(_ profileView: ProfileView)
    func didSelectModel(_ profileView: ProfileView, type: ProfileCellTypes)
    func closePressed(_ editPasswordView: ProfileView)
}

class ProfileView: UIView {
    
    lazy var headerView: HeaderView = {
        let view = HeaderView(model: self.model, settings: self.settings)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        self.addSubview(view)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: kProfileCell)
        self.addSubview(tableView)
        return tableView
    }()
    
    lazy var btnBack: UIButton = {
        let button = UIButton()
        let buttonImage = self.settings.closeImage ?? UIImage.getFrom(customClass: EditProfileView.self, nameResource: "close")
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(self.backPressed), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    let kProfileCell = "ProfileCell"
    var delegate: ProfileViewDelegate?
    
    var model: ProfileViewModel {
        didSet {
            self.headerView.model = self.model
            self.tableView.reloadData()
        }
    }
    var settings: ProfileSettings
    var cells: [ProfileCellTypes] = []
    
    init(model: ProfileViewModel, settings: ProfileSettings = .default) {
        self.model = model
        self.settings = settings
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Code init not implemented")
    }
    
    override func didMoveToSuperview() {
        if self.superview == nil {
            
        } else {
            self.setup()
        }
    }
    
    private func setup() {
        self.backgroundColor = .white
        let height: CGFloat = (UIScreen.main.bounds.height * 250 / 667)
        self.headerView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, size: .init(width: 0, height: (height > 250 ? 250 : height)))
        self.tableView.anchor(top: self.headerView.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        if #available(iOS 11.0, *) {
            self.btnBack.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 44, height: 44))
        } else {
            self.btnBack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 44, height: 44))
        }
        self.bringSubviewToFront(self.btnBack)
        
        self.cells = [.mail, .phone, .password, .doc]
        if self.model.cashback != nil {
            self.cells.append(.cashback)
        }
        self.tableView.reloadData()
    }
    
    func setProfileImage(_ image: UIImage) {
        self.headerView.setProfileImage(image)
    }
    
    @objc func backPressed() {
        self.delegate?.closePressed(self)
    }
    
}

extension ProfileView: HeaderViewDelegate {
    func editIamgePressed(_ headerView: HeaderView) {
        self.delegate?.editImage(self)
    }
}

extension ProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectModel(self, type: self.cells[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? ProfileCell)?.setSelection(selected: true)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? ProfileCell)?.setSelection(selected: false)
    }
}

extension ProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kProfileCell, for: indexPath) as! ProfileCell
        cell.settings = self.settings.profileCellSettings
        cell.type = self.cells[indexPath.row]
        cell.model = self.model
        return cell
    }
}
