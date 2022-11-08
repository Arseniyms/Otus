//
//  EditProfileContract.swift
//  EventPasser
//
//  Created by Arseniy Matus on 05.11.2022.
//
//

import Foundation

// MARK: View Output (Presenter -> View)

protocol PresenterToViewEditProfileProtocol: AnyObject {
    func updateEmailValidation(isEmailValid: Bool)
    func updateNameValidation(isNameValid: Bool)
    func updateLastNameValidation(isLastNameValid: Bool)
    func updateAgeValidation(isAgeValid: Bool)

    func updateUserInfo(with user: User)
}

// MARK: View Input (View -> Presenter)

protocol ViewToPresenterEditProfileProtocol: AnyObject {
    var email: String { get }
    var name: String { get }
    var lastName: String { get }
    var age: String { get }

    var view: PresenterToViewEditProfileProtocol? { get set }
    var interactor: PresenterToInteractorEditProfileProtocol? { get set }
    var router: PresenterToRouterEditProfileProtocol? { get set }

    func emailDidChange(_ email: String)
    func nameDidChange(_ name: String)
    func lastNameDidChange(_ lastName: String)
    func ageDidChange(_ age: String)

    func viewDidLoad()
    func save(name: String?, lastName: String?, age: String?, email: String?)
    func exit()
}

// MARK: Interactor Input (Presenter -> Interactor)

protocol PresenterToInteractorEditProfileProtocol: AnyObject {
    var presenter: InteractorToPresenterEditProfileProtocol? { get set }

    var user: User? { get set }

    func loadUser()
    func presenterDidLoad()
    func saveUser(name: String?, lastName: String?, age: String?, email: String?)

    func validateEmail(_ email: String)
    func validateName(_ name: String)
    func validateLastName(_ lastName: String)
    func validateAge(_ age: String)
}

// MARK: Interactor Output (Interactor -> Presenter)

protocol InteractorToPresenterEditProfileProtocol: AnyObject {
    func setUser(_ user: User)

    func fetchValidEmail(_ bool: Bool)
    func fetchValidName(_ bool: Bool)
    func fetchValidLastName(_ bool: Bool)
    func fetchValidAge(_ bool: Bool)
}

// MARK: Router Input (Presenter -> Router)

protocol PresenterToRouterEditProfileProtocol: AnyObject {
    func saveEditProfile(_ view: PresenterToViewEditProfileProtocol, info: User)
    func dismissEditProfile(_ view: PresenterToViewEditProfileProtocol)
}
