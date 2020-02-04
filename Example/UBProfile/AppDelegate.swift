//
//  AppDelegate.swift
//  UBProfile
//
//  Created by Tulio Parreiras on 04/02/2019.
//  Copyright (c) 2019 Tulio Parreiras. All rights reserved.
//

import UIKit
import UBProfile

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: ProfileCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigation = UINavigationController()
        let coordinator = ProfileCoordinator(navigationController: navigation)
        let settings = ProfileSettings(headerBGColor: .blue, mainColor: #colorLiteral(red: 1, green: 0.5725490196, blue: 0, alpha: 1), nameFont: .systemFont(ofSize: 14))
//        settings.language = .es
        let viewModel: ProfileViewModel = ProfileViewModel(name: "Tulio", lastName: "Parreiras", rate: 4.5, profileImage: "https://scontent.fcnf1-1.fna.fbcdn.net/v/t1.0-9/388816_211336025612084_1271640720_n.jpg?_nc_cat=109&_nc_ht=scontent.fcnf1-1.fna&oh=79edf8e91a78a7c3b47b00c8539c098a&oe=5D19B87B", email: "tulio+emailmuitograndepraquebrarlayout@usemobile.xyz", phone: "31984923952", cpf: "07075577638", cashback: 0.09900990094953001)
        coordinator.start(model: viewModel, settings: settings)
        self.coordinator = coordinator
        self.coordinator?.delegate = self
         
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: ProfileCoordinatorDelegate {
    
    func didEditProfileImage(_ coordinator: ProfileCoordinator, _ viewController: ProfileViewController, image: UIImage) {
        print("Did Select Image: ", image)
    }
    func didRequestEditProfile(_ coordinator: ProfileCoordinator, _ viewController: EditProfileViewController, text: String, type: ProfileCellTypes) {
        viewController.playProgress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            viewController.stopProgress()
            coordinator.navigationController.popToRootViewController(animated: true)
        }
    }
    func didFailedEditProfile(_ coordinator: ProfileCoordinator, _ viewController: EditProfileViewController, errorMessage: String) {
        viewController.showAlertCommon(message: errorMessage)
    }
    func didRequestEditPassword(_ coordinator: ProfileCoordinator, _ viewController: EditPasswordViewController, currentPassword: String, newPassword: String) {
        coordinator.navigationController.popToRootViewController(animated: true)
    }
    func didFailedEditPassword(_ coordinator: ProfileCoordinator, _ viewController: EditPasswordViewController, errorMessage: String) {
        viewController.showAlertCommon(message: errorMessage)
    }
    func didFinish(_ coordinator: ProfileCoordinator) {
        
    }
}

extension UIViewController {
    
    func showAlertCommon(title: String = "Ops!", message: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(btnOk)
        self.present(alert, animated: true, completion: nil)
}
}
