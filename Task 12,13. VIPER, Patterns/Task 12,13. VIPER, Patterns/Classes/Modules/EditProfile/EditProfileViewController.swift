//
//  EditProfileViewController.swift
//  EventPasser
//
//  Created by Arseniy Matus on 05.11.2022.
//
//

import UIKit

class EditProfileViewController: UIViewController {
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItems()
        setupScrollView()
        setupUI()
        updateSaveItem()
        presenter?.viewDidLoad()
    }

    // MARK: - Properties

    var isEmailValid = false
    var isNameValid = false
    var isLastnameValid = false
    var isAgeValid = false

    var presenter: ViewToPresenterEditProfileProtocol?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.bounds.height * 2)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10

        return stackView
    }()

    lazy var emailTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        textField.text = "Loading..."
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.setBorderStyle(autocorrectionType: .no, autocapitalizationType: .none)
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.addAction(UIAction { [weak self] _ in
            if let self {
                self.presenter?.emailDidChange(textField.text ?? "")
                textField.textColor = self.isEmailValid ? .dynamic(light: .black, dark: .white) : .red
            }
        },
        for: .editingChanged)
        textField.delegate = self
        textField.tag = 1

        return textField
    }()

    private lazy var nameTextField: UITextField = {
        let textField = self.getInfoTextLabel(of: "Loading...")
        textField.tag = 2
        textField.textContentType = .givenName
        textField.addAction(UIAction { [weak self] _ in
            if let self {
                self.presenter?.nameDidChange(textField.text ?? "")
                textField.textColor = self.isNameValid ? .dynamic(light: .black, dark: .white) : .red
            }
        }, for: .editingChanged)

        return textField
    }()

    private lazy var lastNameTextField: UITextField = {
        let textField = self.getInfoTextLabel(of: "Loading...")
        textField.tag = 3
        textField.textContentType = .familyName
        textField.textColor = .dynamic(light: .black, dark: .white)
        textField.addAction(UIAction { [weak self] _ in
            if let self {
                self.presenter?.lastNameDidChange(textField.text ?? "")
                textField.textColor = self.isLastnameValid ? .dynamic(light: .black, dark: .white) : .red
            }
        }, for: .editingChanged)

        return textField
    }()

    private lazy var ageTextField: UITextField = {
        let textField = self.getInfoTextLabel(of: "Loading...")
        textField.tag = 4
        textField.keyboardType = .numberPad
        textField.textColor = .dynamic(light: .black, dark: .white)
        textField.addAction(UIAction { [weak self] _ in
            if let self {
                self.presenter?.ageDidChange(textField.text ?? "")
                textField.textColor = self.isAgeValid ? .dynamic(light: .black, dark: .white) : .red
            }
        }, for: .editingChanged)

        return textField
    }()

    // MARK: - Functions

    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .close, primaryAction: UIAction { [weak self] _ in
            self?.presenter?.exit()
        })
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save, primaryAction: UIAction { [weak self] _ in
            self?.presenter?.save(name: self?.nameTextField.text,
                                  lastName: self?.lastNameTextField.text,
                                  age: self?.ageTextField.text,
                                  email: self?.emailTextField.text)
        })
    }

    func setupScrollView() {
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        scrollView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

        ])
    }

    func setupUI() {
        view.backgroundColor = .systemBackground

        stackView.addArrangedSubview(self.getInfoLabel("Почта"))
        stackView.addArrangedSubview(emailTextField)

        stackView.addArrangedSubview(self.getInfoLabel("Имя"))
        stackView.addArrangedSubview(nameTextField)

        stackView.addArrangedSubview(self.getInfoLabel("Фамилия"))
        stackView.addArrangedSubview(lastNameTextField)

        stackView.addArrangedSubview(self.getInfoLabel("Возраст"))
        stackView.addArrangedSubview(ageTextField)
    }

    func updateSaveItem() {
        navigationItem.rightBarButtonItem?.isEnabled = isEmailValid && isNameValid && isLastnameValid && isAgeValid
    }
}

extension EditProfileViewController {
    func getInfoLabel(_ info: String) -> UILabel {
        let label = UILabel()
        label.text = info
        label.font = .boldSystemFont(ofSize: 18)

        return label
    }
}

extension EditProfileViewController: PresenterToViewEditProfileProtocol {
    func updateUserInfo(with user: User) {
        self.emailTextField.text = user.email
        self.nameTextField.text = user.name
        self.lastNameTextField.text = user.lastName
        self.ageTextField.text = "\(user.age)"
    }

    func updateEmailValidation(isEmailValid: Bool) {
        self.isEmailValid = isEmailValid
        updateSaveItem()
    }

    func updateNameValidation(isNameValid: Bool) {
        self.isNameValid = isNameValid
        updateSaveItem()
    }

    func updateLastNameValidation(isLastNameValid: Bool) {
        self.isLastnameValid = isLastNameValid
        updateSaveItem()
    }

    func updateAgeValidation(isAgeValid: Bool) {
        self.isAgeValid = isAgeValid
        updateSaveItem()
    }
}
