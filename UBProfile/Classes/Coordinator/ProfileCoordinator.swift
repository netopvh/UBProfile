//
//  ProfileCoordinator.swift
//  UBProfile
//
//  Created by Usemobile on 02/04/19.
//

import Foundation
import USE_Coordinator

public protocol ProfileCoordinatorDelegate {
    func didEditProfileImage(_ coordinator: ProfileCoordinator, _ viewController: ProfileViewController, image: UIImage)
    func didRequestEditProfile(_ coordinator: ProfileCoordinator, _ viewController: EditProfileViewController, text: String, type: ProfileCellTypes)
    func didFailedEditProfile(_ coordinator: ProfileCoordinator, _ viewController: EditProfileViewController, errorMessage: String)
    func didRequestEditPassword(_ coordinator: ProfileCoordinator, _ viewController: EditPasswordViewController, currentPassword: String, newPassword: String)
    func didFailedEditPassword(_ coordinator: ProfileCoordinator, _ viewController: EditPasswordViewController, errorMessage: String)
    func didFinish(_ coordinator: ProfileCoordinator)
}

public class ProfileCoordinator: NavigationCoordinator {
    
    public var settings: ProfileSettings = .default
    public var delegate: ProfileCoordinatorDelegate?
    
    public func start(model: ProfileViewModel, settings: ProfileSettings = .default) {
        self.settings = settings
        let root = ProfileViewController(model: model, settings: settings)
        root.delegate = self
        root.coordinator = self
        self.navigationController.pushViewController(root, animated: true)
    }
    
    public func update(model: ProfileViewModel) {
        for child in self.navigationController.children {
            if let vc = child as? ProfileViewController {
                vc.model = model
            }
        }
    }
    
    public func edit(model: ProfileViewModel, type: ProfileCellTypes) {
        switch type {
        case .mail, .phone:
            self.presentEditVC(model: model, type: type)
        case .password:
            self.presentEditPasswordVC(model: model)
        default:
            break
        }
    }
    
    public func presentEditVC(model: ProfileViewModel, type: ProfileCellTypes) {
        let vc = EditProfileViewController(model: model, type: type, settings: settings)
        vc.coordinator = self
        vc.delegate = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func presentEditPasswordVC(model: ProfileViewModel) {
        let vc = EditPasswordViewController(model: model, type: .password, settings: settings)
        vc.coordinator = self
        vc.delegate = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        self.navigationController.dismiss(animated: true, completion: nil)
        if let parent = self.parentCoordinator {
            parent.childDidFinish(self)
        }
        self.delegate?.didFinish(self)
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func didEditProfileImage(_ viewController: ProfileViewController, image: UIImage) {
        self.delegate?.didEditProfileImage(self, viewController, image: image)
    }
}

extension ProfileCoordinator: EditProfileViewControllerDelegate {
    func didRequestEditProfile(_ viewController: EditProfileViewController, text: String, type: ProfileCellTypes) {
        self.delegate?.didRequestEditProfile(self, viewController, text: text, type: type)
    }
    func didFailedEditProfile(_ viewController: EditProfileViewController, errorMessage: String) {
        self.delegate?.didFailedEditProfile(self, viewController, errorMessage: errorMessage)
    }
}

extension ProfileCoordinator: EditPasswordViewControllerDelegate {
    func didRequestEditPassword(_ viewController: EditPasswordViewController, currentPassword: String, newPassword: String) {
        self.delegate?.didRequestEditPassword(self, viewController, currentPassword: currentPassword, newPassword: newPassword)
    }
    func didFailedEditPassword(_ viewController: EditPasswordViewController, errorMessage: String) {
        self.delegate?.didFailedEditPassword(self, viewController, errorMessage: errorMessage)
    }
}
