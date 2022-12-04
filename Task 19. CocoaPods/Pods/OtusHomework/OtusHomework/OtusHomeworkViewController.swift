//
//  OtusHomeworkViewController.swift
//  OtusHomework
//
//  Created by Гладковский Николай Сергеевич on 28.11.2022.
//

import Foundation
import UIKit
import SnapKit

public protocol HasOtusHomeworkView: AnyObject {
    /// Необходимо передать ваш UIView либо nil если хотите использовать UIViewController
    var squareView: UIView? { get }
    
    /// Необходимо передать ваш UIViewController либо nil если хотите использовать UIView
    var squareViewController: UIViewController? { get }
}

public class OtusHomeworkViewController: UIViewController {
    public override func viewDidLoad() {
        view.backgroundColor = .gray
        let studentLabel = UILabel()
        studentLabel.font = .systemFont(ofSize: 48, weight: .ultraLight)
        studentLabel.text = "ФИО Студента"
        studentLabel.textColor = .darkGray
        studentLabel.textAlignment = .center
        studentLabel.numberOfLines = 0
        view.addSubview(studentLabel)
        
        studentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension OtusHomeworkViewController: HasOtusHomeworkView {
    public var squareView: UIView? {
        view
    }
    
    public var squareViewController: UIViewController? {
        self
    }
}
