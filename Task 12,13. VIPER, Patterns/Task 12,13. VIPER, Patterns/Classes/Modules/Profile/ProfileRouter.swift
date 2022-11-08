//
//  ProfileRouter.swift
//  EventPasser
//
//  Created by Arseniy Matus on 21.10.2022.
//
//

import Foundation
import UIKit

class ProfileRouter: PresenterToRouterProfileProtocol {
    // MARK: Static methods

    static func createModule() -> UINavigationController {
        let viewController = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: viewController)

        let presenter: ViewToPresenterProfileProtocol & InteractorToPresenterProfileProtocol = ProfilePresenter()

        viewController.presenter = presenter
        viewController.presenter?.router = ProfileRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ProfileInteractor()
        viewController.presenter?.interactor?.presenter = presenter

        return navigationController
    }

    func presentEditProfile(on view: PresenterToViewProfileProtocol) {
        let editProfileViewController = EditProfileRouter.createModule()

        let vc = view as! ProfileViewController
        vc.present(editProfileViewController, animated: true)
    }
}
