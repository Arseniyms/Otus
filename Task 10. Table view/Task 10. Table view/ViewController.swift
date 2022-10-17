//
//  ViewController.swift
//  Task 10. Table view
//
//  Created by Arseniy Matus on 16.10.2022.
//

import UIKit

class ViewController: UIViewController {
    let colors = [Color(name: "red", UICol: .red),
                  Color(name: "blue", UICol: .blue),
                  Color(name: "green", UICol: .green),
                  Color(name: "yellow", UICol: .yellow),
                  Color(name: "purple", UICol: .purple),
                  Color(name: "pink", UICol: .systemPink),
                  Color(name: "black", UICol: .black),
    ]
    
    
    var tableView = UITableView()
    let identifier = "Cell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Task 10"
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(MyCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MyCell
        cell?.setColor(color: colors[indexPath.row].name)
        return cell ?? MyCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let colorViewController = ColorViewController()
        colorViewController.color = colors[indexPath.row]
        self.navigationController?.pushViewController(colorViewController, animated: true)
    }
}

