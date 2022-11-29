//
//  ViewController.swift
//  Task 16,17,18. URLSession, CoreData, Userdefaults
//
//  Created by Arseniy Matus on 27.11.2022.
//

import UIKit

class ViewController: UIViewController {
    private var dataStorage = DataStorages.coreData

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        setupUI()
    }

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Поиск по имени"
        textField.borderStyle = .roundedRect

        return textField
    }()

    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self

        return picker
    }()

    private lazy var loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Скачать данные", for: .normal)
        button.setTitleColor(.black, for: .normal)

        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.tintColor = .black

        button.addTarget(self, action: #selector(loadButtonPressed), for: .touchUpInside)

        return button
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Поиск по данным", for: .normal)

        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.tintColor = .black
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10

        return stackView
    }()

    func setupUI() {
        view.backgroundColor = .systemBackground

        stackView.addArrangedSubview(picker)

        stackView.addArrangedSubview(loadButton)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(searchButton)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }

    var users = [UserData]()

    @objc func loadButtonPressed(_: UIButton) {
        ApiService.shared.loadData(to: dataStorage) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.presentAlert(title: "Успешно", message: "")
                }
            case let .failure(error):
                self?.presentAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }

    @objc func searchButtonPressed(_: UIButton) {
        var results: [CacheUser]? = nil
        switch dataStorage {
        case .userDefaults:
            results = try? DataService.shared.getFromUserDefaults(by: textField.text ?? "")
        case .coreData:
            results = try? DataService.shared.getFromCoreData(by: textField.text ?? "")
        }
        guard let results, !results.isEmpty else {
            presentAlert(title: "Ошибка", message: "Нет похожих результатов")
            return
        }

        let alert = UIAlertController(title: nil , message: "Результаты поиска", preferredStyle: .actionSheet)
        for user in results {
            let action = UIAlertAction(title: "\(user.user.firstName) \(user.user.lastName)\n\(user.user.email)", style: .default)
            action.setValue(0, forKey: "titleTextAlignment")
            action.setValue(user.image?.withRenderingMode(.alwaysOriginal), forKey: "image")
            alert.addAction(action)
        }
        UILabel.appearance(whenContainedInInstancesOf:[UIAlertController.self]).numberOfLines = 2
        alert.view.tintColor = .black
        
        alert.addAction(UIAlertAction(title: "Готово", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        2
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        if row == 0 {
            return DataStorages.coreData.description
        } else {
            return DataStorages.userDefaults.description
        }
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        if row == 0 {
            dataStorage = .coreData
        } else {
            dataStorage = .userDefaults
        }
    }
}
