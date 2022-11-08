//
//  EditProfileRouter.swift
//  EventPasser
//
//  Created by Arseniy Matus on 05.11.2022.
//
//

import UIKit

class EditProfileRouter: PresenterToRouterEditProfileProtocol {
    // MARK: Static methods

    static func createModule() -> UIViewController {
        let viewController = EditProfileViewController()
        let navigationController = UINavigationController(rootViewController: viewController)

        let presenter: ViewToPresenterEditProfileProtocol & InteractorToPresenterEditProfileProtocol = EditProfilePresenter()

        viewController.presenter = presenter
        viewController.presenter?.router = EditProfileRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = EditProfileInteractor()
        viewController.presenter?.interactor?.presenter = presenter

        return navigationController
    }

    func saveEditProfile(_ view: PresenterToViewEditProfileProtocol, info: User) {
        let vc = view as! EditProfileViewController
        vc.presenter?.interactor?.user = info

        vc.dismiss(animated: true)
    }

    func dismissEditProfile(_ view: PresenterToViewEditProfileProtocol) {
        let vc = view as! EditProfileViewController

        let nc = vc.presentingViewController as! UINavigationController
        if let parentVC = nc.viewControllers.first as? ProfileViewController {
            parentVC.presenter?.viewDidLoad()
        }

        vc.dismiss(animated: true)
    }
}
