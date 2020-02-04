
//
//  EditPasswordViewController.swift
//  UBProfile
//
//  Created by Usemobile on 04/04/19.
//

import Foundation

protocol EditPasswordViewControllerDelegate {
    func didRequestEditPassword(_ viewController: EditPasswordViewController, currentPassword: String, newPassword: String)
    func didFailedEditPassword(_ viewController: EditPasswordViewController, errorMessage: String)
}

public class EditPasswordViewController: BaseEditProfileVC {
    
    lazy var editPasswordView: EditPasswordView = {
        let view = EditPasswordView(settings: self.settings)
        view.delegate = self
        return view
    }()
    
    var delegate: EditPasswordViewControllerDelegate?
    
    public override func loadView() {
        self.view = self.editPasswordView
    }
    
    public override func playProgress() {
        self.editPasswordView.playProgress()
    }
    
    public override func stopProgress(failure: Bool = false) {
        self.editPasswordView.stopProgress(failure: failure)
    }
}

extension EditPasswordViewController: EditPasswordViewDelegate {
    func saveSuccess(_ editPasswordView: EditPasswordView, currentPassword: String, newPassword: String) {
        self.delegate?.didRequestEditPassword(self, currentPassword: currentPassword, newPassword: newPassword)
    }
    func saveFailure(_ editPasswordView: EditPasswordView, errorMessage: String) {
        self.delegate?.didFailedEditPassword(self, errorMessage: errorMessage)
    }
}
