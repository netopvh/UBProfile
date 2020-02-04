//
//  BaseEditProfileVC.swift
//  UBProfile
//
//  Created by Usemobile on 04/04/19.
//

import Foundation
import USE_Coordinator

public class BaseEditProfileVC: CoordinatedViewController {
    
    lazy var viewFakeNavBarBG: UIView = {
        let view = UIView()
        view.backgroundColor = self.navigationController?.navigationBar.barTintColor ?? .white
        return view
    }()
    
    var model: ProfileViewModel
    var type: ProfileCellTypes
    var settings: ProfileSettings
    
    public required init(model: ProfileViewModel, type: ProfileCellTypes, settings: ProfileSettings = .default) {
        self.model = model
        self.type = type
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFakeNavBar()
        self.setTitle()
    }
    
    public func setTitle() {
        var typeText: String = ""
        switch self.type {
        case .mail:
            typeText = .email
        case .phone:
            typeText = .phone
        case .password:
            typeText = .password
        case .doc:
            typeText = .cpf
        case .cashback:
            typeText = .cashback
        }
        self.title = typeText.capitalized
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
     
    private func setupFakeNavBar() {
        let size = UIApplication.shared.statusBarFrame.size.height + 44
        self.view.insertSubview(self.viewFakeNavBarBG, at: 0)
        self.viewFakeNavBarBG.frame = .init(x: 0, y: -size, width: UIScreen.main.bounds.width, height: size)
    }
    
    public func playProgress() {
        
    }
    
    public func stopProgress(failure: Bool = false) {
        
    }
}
