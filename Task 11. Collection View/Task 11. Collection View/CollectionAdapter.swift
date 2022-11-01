//
//  CollectionAdapter.swift
//  Task 11. Collection View
//
//  Created by Arseniy Matus on 01.11.2022.
//

import UIKit

class CollectionAdapter: NSObject {
    var images = [Image]()
    
    override init() {
        images = [
            Image(name: "Winter", image: UIImage(named: "winter")!),
            Image(name: "Summer", image: UIImage(named: "summer")!),
            Image(name: "Autumn", image: UIImage(named: "autumn")!),
            Image(name: "Spring", image: UIImage(named: "spring")!)
        ]
    }
}

extension CollectionAdapter: UICollectionViewDelegate {
    
}

extension CollectionAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        let image = images[indexPath.row]
        
        cell.setup(with: image)
        return cell
    }
    
}

extension CollectionAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: 180, height: 180)
    }
    
}

