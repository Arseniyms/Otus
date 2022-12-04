//
//  ProfileLogicTests.swift
//  Task 12,13. VIPER, PatternsTests
//
//  Created by Arseniy Matus on 04.12.2022.
//

import XCTest


@testable import Task_12_13__VIPER__Patterns

final class ProfileLogicTests: XCTestCase {
    
    var interactor: PresenterToInteractorEditProfileProtocol?
    var presenter = EditProfileMockPresenter()

    override func setUpWithError() throws {
        interactor = EditProfileInteractor()
        interactor?.presenter = presenter
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidEmail() {
        interactor?.validateEmail("arsmatus@list.ru")
        XCTAssertTrue(presenter.isEmailValid)
    }
    
    func testWrongEmail() {
        interactor?.validateEmail("arsmatus@listru")
        XCTAssertFalse(presenter.isEmailValid)
    }
    
    func testValidName() {
        interactor?.validateName("Arseniy")
        XCTAssertTrue(presenter.isNameValid)
    }
    
    func testWrongName() {
        interactor?.validateName("Arseniy39")
        XCTAssertFalse(presenter.isNameValid)
    }
    
    func testValidLastName() {
        interactor?.validateName("Matus")
        XCTAssertTrue(presenter.isNameValid)
    }
    
    func testWrongLastName() {
        interactor?.validateName("")
        XCTAssertFalse(presenter.isNameValid)
    }
    
    func testValidAge() {
        interactor?.validateAge("21")
        XCTAssertTrue(presenter.isAgeValid)
    }

    func testWrongaAge() {
        interactor?.validateAge("-1")
        XCTAssertFalse(presenter.isAgeValid)
    }
    
    func testWrongaStringAge() {
        interactor?.validateAge("twenty-one")
        XCTAssertFalse(presenter.isAgeValid)
    }
    
    func testLoadUser() {
        interactor?.loadUser()
        let savedUser = Storage.shared.getUser()
        XCTAssertEqual(presenter.user, savedUser)
    }
    
    func testUser() {
        interactor?.loadUser()
        let userToSave = User(name: "Arseniy", lastName: "Matus", age: 21, email: "arsmatus@list.ru")
        interactor?.saveUser(name: userToSave.name, lastName: userToSave.lastName, age: "\(userToSave.age)", email: userToSave.email)
        
        let savedUser = Storage.shared.getUser()
        XCTAssertEqual(userToSave, savedUser)
    }
}

class EditProfileMockPresenter: InteractorToPresenterEditProfileProtocol {
    var isEmailValid = false
    var isNameValid = false
    var isLastNameValid = false
    var isAgeValid = false
        
    var user = User(name: "", lastName: "", age: 0, email: "")
    
    func setUser(_ user: Task_12_13__VIPER__Patterns.User) {
        self.user = user
    }
    
    func fetchValidEmail(_ bool: Bool) {
         isEmailValid = bool
    }
    
    func fetchValidName(_ bool: Bool) {
        isNameValid = bool
    }
    
    func fetchValidLastName(_ bool: Bool) {
        isLastNameValid = bool
    }
    
    func fetchValidAge(_ bool: Bool) {
        isAgeValid = bool
    }
    
    
}

