//
//  EditProfilePresenter.swift
//  EventPasser
//
//  Created by Arseniy Matus on 05.11.2022.
//
//

import Foundation

class EditProfilePresenter: ViewToPresenterEditProfileProtocol {
    var email = ""
    var name = ""
    var lastName = ""
    var age = ""

    // MARK: Properties

    weak var view: PresenterToViewEditProfileProtocol?
    var interactor: PresenterToInteractorEditProfileProtocol?
    var router: PresenterToRouterEditProfileProtocol?

    func emailDidChange(_ email: String) {
        interactor?.validateEmail(email)
    }

    func nameDidChange(_ name: String) {
        interactor?.validateName(name)
    }

    func lastNameDidChange(_ lastName: String) {
        interactor?.validateLastName(lastName)
    }

    func ageDidChange(_ age: String) {
        interactor?.validateAge(age)
    }

    func viewDidLoad() {
        interactor?.loadUser()
        interactor?.presenterDidLoad()
    }

    func save(name: String?, lastName: String?, age: String?, email: String?) {
        interactor?.saveUser(name: name, lastName: lastName, age: age, email: email)
        router?.dismissEditProfile(view!)
    }

    func exit() {
        router?.dismissEditProfile(view!)
    }
}

extension EditProfilePresenter: InteractorToPresenterEditProfileProtocol {
    func setUser(_ user: User) {
        view?.updateUserInfo(with: user)
    }

    func fetchValidEmail(_ bool: Bool) {
        view?.updateEmailValidation(isEmailValid: bool)
    }

    func fetchValidName(_ bool: Bool) {
        view?.updateNameValidation(isNameValid: bool)
    }

    func fetchValidLastName(_ bool: Bool) {
        view?.updateLastNameValidation(isLastNameValid: bool)
    }

    func fetchValidAge(_ bool: Bool) {
        view?.updateAgeValidation(isAgeValid: bool)
    }
}
