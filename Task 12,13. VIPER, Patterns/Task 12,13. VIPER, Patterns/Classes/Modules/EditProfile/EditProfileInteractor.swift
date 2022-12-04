//
//  EditProfileInteractor.swift
//  EventPasser
//
//  Created by Arseniy Matus on 05.11.2022.
//
//

import Foundation

class EditProfileInteractor: PresenterToInteractorEditProfileProtocol {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    // MARK: Properties

    weak var presenter: InteractorToPresenterEditProfileProtocol?

    var user: User?

    func presenterDidLoad() {
        validateEmail(user?.email ?? "")
        validateName(user?.name ?? "")
        validateLastName(user?.lastName ?? "")
        validateAge("\(user?.age ?? 0)")
    }

    func loadUser() {
        user = Storage.shared.getUser()
        presenter?.setUser(user!)
    }

    func saveUser(name: String?, lastName: String?, age: String?, email: String?) {
        user?.name = name ?? "Error"
        user?.email = email ?? "Error"
        user?.lastName = lastName ?? "Error"
        user?.age = Int(age ?? "Error") ?? 0
        Storage.shared.setUser(user!)
    }

    func validateEmail(_ email: String) {
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        presenter?.fetchValidEmail(emailPred.evaluate(with: email))
    }

    func validateName(_ name: String) {
        let numbersRange = name.rangeOfCharacter(from: .decimalDigits)
        let hasNumbers = (numbersRange != nil)
        presenter?.fetchValidName(!name.isEmpty && !hasNumbers)
    }

    func validateLastName(_ lastName: String) {
        let numbersRange = lastName.rangeOfCharacter(from: .decimalDigits)
        let hasNumbers = (numbersRange != nil)
        presenter?.fetchValidLastName(!lastName.isEmpty && !hasNumbers)
    }

    func validateAge(_ age: String) {
        if let intAge = Int(age), intAge > 0 {
            presenter?.fetchValidAge(true)
        } else {
            presenter?.fetchValidAge(false)
        }
    }
}
