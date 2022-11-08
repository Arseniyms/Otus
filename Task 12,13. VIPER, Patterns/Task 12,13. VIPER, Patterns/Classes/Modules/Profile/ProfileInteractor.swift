//
//  ProfileInteractor.swift
//  EventPasser
//
//  Created by Arseniy Matus on 21.10.2022.
//
//

import Foundation

class ProfileInteractor: PresenterToInteractorProfileProtocol {
    // MARK: Properties

    weak var presenter: InteractorToPresenterProfileProtocol?

    func loadUser() {
        presenter?.setUser(Storage.shared.getUser())
    }
}
