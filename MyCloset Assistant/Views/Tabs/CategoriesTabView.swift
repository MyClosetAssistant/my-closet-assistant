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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UICollectionViewCell,
              let indexPath = categoriesCollectionView.indexPath(for: cell),
              let destination = segue.destination as? ResultsView else {
            return
        }
        
        let category = categories[indexPath.row]
        destination.navigationBar.title = category
        queryClosetItems(with: category) { items in
            destination.items = items
            DispatchQueue.main.async {
                destination.itemsTableView.reloadData()
            }
        }
    }
    
    // MARK: Private helpers
    
    private func queryClosetItems(with category: String, completion: @escaping ([ClosetItem]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            ClosetItem.query().include("user").find { queryResults in
                switch queryResults {
                case .success(let results):
                    let items = results.filter { $0.categories == nil || $0.categories!.contains(category) }
                    completion(items)
                case .failure(let error):
                    fatalError("\(error.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func onLogOutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }
    
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of \(User.current?.username ?? "current account")?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
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
