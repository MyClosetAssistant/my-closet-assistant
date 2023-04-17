//
//  BrandsTabView.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/13/23.
//

import UIKit

class BrandsTabView: UIViewController {
    
    var brands: [String] = User.current!.brands ?? []
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brandsCollectionView.dataSource = self
        updateCollectionViewLayout()
        brandsCollectionView.reloadData()
    }
    
}

// MARK: Conform BrandsTabView to UICollectionViewDataSource

extension BrandsTabView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = brandsCollectionView.dequeueReusableCell(withReuseIdentifier: BrandsTableCell.reusableId, for: indexPath) as! BrandsTableCell
        let currentBrand = brands[indexPath.item]
        cell.brandsTextLabel.text = currentBrand
        cell.layer.cornerRadius = 10
        return cell
    }
    
    private func updateCollectionViewLayout() {
        let layout = brandsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4

        let numberOfColumns: CGFloat = 3
        let width = (brandsCollectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns
        layout.itemSize = CGSize(width: width, height: width)
    }
    
}
