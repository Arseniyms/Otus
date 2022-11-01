//
//  ViewController.swift
//  Task 11. Collection View
//
//  Created by Arseniy Matus on 31.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let adapter = CollectionAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        collectionView.reloadData()
    }

    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        
        return collectionView
    } ()
    
    func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
   

}

