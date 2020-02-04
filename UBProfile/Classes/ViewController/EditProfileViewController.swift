//
//  EditProfileViewController.swift
//  UBProfile
//
//  Created by Usemobile on 03/04/19.
//

import Foundation

protocol EditProfileViewControllerDelegate {
    func didRequestEditProfile(_ viewController: EditProfileViewController, text: String, type: ProfileCellTypes)
    func didFailedEditProfile(_ viewController: EditProfileViewController, errorMessage: String)
}

public class EditProfileViewController: BaseEditProfileVC {
    
    lazy var editProfileView: EditProfileView = {
        let view = EditProfileView(model: self.model, type: self.type, settings: self.settings)
        view.delegate = self
        return view
    }()
    
    override var model: ProfileViewModel {
        didSet {
            self.editProfileView.model = self.model
        }
    }
    
    var delegate: EditProfileViewControllerDelegate?
    
    public override func loadView() {
        self.view = self.editProfileView
    }
    
    public override func playProgress() {
        self.editProfileView.playProgress()
    }
    
    public override func stopProgress(failure: Bool = false) {
        self.editProfileView.stopProgress(failure: failure)
    }
    
}

extension EditProfileViewController: EditProfileViewDelegate {
    func saveSuccess(_ editPasswordView: EditProfileView, newValue: String, model: ProfileCellTypes) {
        self.delegate?.didRequestEditProfile(self, text: newValue, type: model)
    }
    func saveFailure(_ editPasswordView: EditProfileView, errorMessage: String) {
        self.delegate?.didFailedEditProfile(self, errorMessage: errorMessage)
    }
}
