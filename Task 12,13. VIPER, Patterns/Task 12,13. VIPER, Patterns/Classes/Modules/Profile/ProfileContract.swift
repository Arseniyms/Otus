//
//  ProfileContract.swift
//  EventPasser
//
//  Created by Arseniy Matus on 21.10.2022.
//
//

import UIKit

// MARK: View Output (Presenter -> View)

protocol PresenterToViewProfileProtocol: AnyObject {
    func updateUserInfo(with user: User)
}

// MARK: View Input (View -> Presenter)

protocol ViewToPresenterProfileProtocol: AnyObject {
    var view: PresenterToViewProfileProtocol? { get set }
    var interactor: PresenterToInteractorProfileProtocol? { get set }
    var router: PresenterToRouterProfileProtocol? { get set }

    func viewDidLoad()
    func goToEditProfile()
}

// MARK: Interactor Input (Presenter -> Interactor)

protocol PresenterToInteractorProfileProtocol: AnyObject {
    var presenter: InteractorToPresenterProfileProtocol? { get set }

    func loadUser()
}

// MARK: Interactor Output (Interactor -> Presenter)

protocol InteractorToPresenterProfileProtocol: AnyObject {
    func setUser(_ user: User)
}

// MARK: Router Input (Presenter -> Router)

protocol PresenterToRouterProfileProtocol: AnyObject {
    static func createModule() -> UINavigationController

    func presentEditProfile(on view: PresenterToViewProfileProtocol)
}
