//
//  ProfileViewController.swift
//  UBProfile
//
//  Created by Usemobile on 02/04/19.
//

import Foundation
import UIKit
import USE_Coordinator
import MobileCoreServices

protocol ProfileViewControllerDelegate {
    func didEditProfileImage(_ viewController: ProfileViewController, image: UIImage)
}

public class ProfileViewController: CoordinatedViewController {
    
    lazy var profileView: ProfileView = {
        let view = ProfileView(model: self.model, settings: self.settings)
        view.delegate = self
        return view
    }()
    
    let picker = UIImagePickerController()
    
    var model: ProfileViewModel {
        didSet {
            self.profileView.model = self.model
        }
    }
    var settings: ProfileSettings
    var delegate: ProfileViewControllerDelegate?
    
    init(model: ProfileViewModel, settings: ProfileSettings = .default) {
        self.model = model
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Coder init not implemented")
    }
    
    public override func loadView() {
        self.view = self.profileView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        self.title = " "
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func present() {
        self.picker.delegate = self
        let alertController = UIAlertController(title: .selectImage, message: nil, preferredStyle: .actionSheet)
        let cameraButton = UIAlertAction(title: .takePicture, style: .default) { (action) in
            self.getPhotoFromCamera()
        }
        let libButton = UIAlertAction(title: .chooseLibrary, style: .default) { (action) in
            self.getPhotoFromLibrary()
        }
        let cancelButton = UIAlertAction(title: .cancel, style: .cancel, handler: nil)
        alertController.addAction(cameraButton)
        alertController.addAction(libButton)
        alertController.addAction(cancelButton)
        
        alertController.popoverPresentationController?.sourceView = self.view
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getPhotoFromLibrary() {
        self.picker.allowsEditing = true
        self.picker.sourceType = .photoLibrary
        self.picker.mediaTypes = [kUTTypeImage as NSString as String]
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func getPhotoFromCamera() {
        self.picker.allowsEditing = true
        self.picker.sourceType = .camera
        self.picker.cameraCaptureMode = .photo
        self.picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UINavigationControllerDelegate { }

extension ProfileViewController: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileView.setProfileImage(image)
            self.delegate?.didEditProfileImage(self, image: image)
        }
        self.picker.dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileViewController: ProfileViewDelegate {
    func editImage(_ profileView: ProfileView) {
        self.present()
    }
    func didSelectModel(_ profileView: ProfileView, type: ProfileCellTypes) {
        (self.coordinator as? ProfileCoordinator)?.edit(model: self.model, type: type)
    }
    func closePressed(_ editPasswordView: ProfileView) {
        (self.coordinator as? ProfileCoordinator)?.finish()
    }
}
