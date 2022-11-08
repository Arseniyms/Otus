//
//  ProfileViewController.swift
//  EventPasser
//
//  Created by Arseniy Matus on 21.10.2022.
//
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItems()
        setupUI()

        presenter?.viewDidLoad()
    }

    // MARK: - Properties

    var presenter: ViewToPresenterProfileProtocol?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.bounds.height * 2)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var otusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "otus")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .dynamic(light: .black, dark: .white)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()

    private lazy var nameLabel: InfoLabel = InfoLabel.profileInfo(of: "")

    private lazy var lastNameLabel: InfoLabel = InfoLabel.profileInfo(of: "")

    private lazy var ageLabel: InfoLabel = InfoLabel.profileInfo(of: "")

    private lazy var mailLabel: InfoLabel = InfoLabel.profileInfo(of: "")

    private lazy var stackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [otusImageView, nameLabel, lastNameLabel, ageLabel, mailLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fillProportionally

        stackView.setCustomSpacing(100, after: otusImageView)

        return stackView
    }()

    // MARK: - Functions

    func setupNavigationItems() {
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self,
                                   action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItems = [edit]
    }

    func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])

        let scrollContentView = UIView()
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(scrollContentView)
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            scrollContentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
        ])

        _ = stackView.subviews.dropFirst().map {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 40).isActive = true
            $0.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -40).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }

    @objc private func editButtonTapped() {
        presenter?.goToEditProfile()
    }
}

extension ProfileViewController: PresenterToViewProfileProtocol {
    func updateUserInfo(with user: User) {
        nameLabel.text = user.name
        lastNameLabel.text = user.lastName
        ageLabel.text = "\(user.age)"
        mailLabel.text = user.email
    }
}
