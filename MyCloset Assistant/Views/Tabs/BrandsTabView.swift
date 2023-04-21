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

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let cell = sender as? UICollectionViewCell,
      let indexPath = brandsCollectionView.indexPath(for: cell),
      let destination = segue.destination as? ResultsView
    else {
      return
    }

    let brand = brands[indexPath.row]
    destination.navigationBar.title = brand
    queryClosetItems(with: brand) { items in
      destination.items = items
      DispatchQueue.main.async {
        destination.itemsTableView.reloadData()
      }
    }
  }

  // MARK: Private helpers

  private func queryClosetItems(with brand: String, completion: @escaping ([ClosetItem]) -> Void) {
    DispatchQueue.global(qos: .background).async {
      ClosetItem.query().include("user").find { queryResults in
        switch queryResults {
        case .success(let results):
          let items = results.filter { $0.brand == nil || $0.brand! == brand }
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
    let alertController = UIAlertController(
      title: "Log out of \(User.current?.username ?? "current account")?", message: nil,
      preferredStyle: .alert)
    let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
      NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(logOutAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }
}

// MARK: Conform BrandsTabView to UICollectionViewDataSource

extension BrandsTabView: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int
  {
    return brands.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    let cell =
      brandsCollectionView.dequeueReusableCell(
        withReuseIdentifier: BrandsTableCell.reusableId, for: indexPath) as! BrandsTableCell
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
    let width =
      (brandsCollectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1))
      / numberOfColumns
    layout.itemSize = CGSize(width: width, height: width)
  }

}
