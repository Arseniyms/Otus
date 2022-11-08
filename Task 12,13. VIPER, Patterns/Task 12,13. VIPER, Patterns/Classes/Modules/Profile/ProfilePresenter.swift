//
//  ProfilePresenter.swift
//  EventPasser
//
//  Created by Arseniy Matus on 21.10.2022.
//
//

import Foundation

class ProfilePresenter: ViewToPresenterProfileProtocol {
    // MARK: Properties

    weak var view: PresenterToViewProfileProtocol?
    var interactor: PresenterToInteractorProfileProtocol?
    var router: PresenterToRouterProfileProtocol?

    func setUser(_ user: User) {
        view?.updateUserInfo(with: user)
    }

    func viewDidLoad() {
        interactor?.loadUser()
    }

    func goToEditProfile() {
        router?.presentEditProfile(on: view!)
    }
}

extension ProfilePresenter: InteractorToPresenterProfileProtocol {
}
