//
//  CategoriesTabView.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/13/23.
//

import UIKit

class CategoriesTabView: UIViewController {
    
    var categories: [String] = User.current!.categories ?? []
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesCollectionView.dataSource = self
        updateCollectionViewLayout()
        categoriesCollectionView.reloadData()
    }
    
}

// MARK: Conform CategoriesTabView to UICollectionViewDataSource

extension CategoriesTabView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesTableCell.reusableId, for: indexPath) as! CategoriesTableCell
        let currentCategory = categories[indexPath.item]
        cell.categoriesTextLabel.text = currentCategory
        cell.layer.cornerRadius = 10
        return cell
    }
    
    private func updateCollectionViewLayout() {
        let layout = categoriesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4

        let numberOfColumns: CGFloat = 3
        let width = (categoriesCollectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns
        layout.itemSize = CGSize(width: width, height: width)
    }
    
}
