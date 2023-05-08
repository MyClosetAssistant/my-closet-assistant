//
//  ResultsView.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/18/23.
//

import ParseSwift
import UIKit

class ResultsView: UIViewController {

  @IBOutlet weak var itemsTableView: UITableView!
  @IBOutlet weak var navigationBar: UINavigationItem!
  var items: [ClosetItem]!

  // MARK: Overrides

  override func viewDidLoad() {
    super.viewDidLoad()
    itemsTableView.dataSource = self
    itemsTableView.reloadData()
  }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the cell that triggered the segue
        if let cell = sender as? UITableViewCell,
           // Get the index path of the cell from the table view
           let indexPath = itemsTableView.indexPath(for: cell),
           // Get the detail view controller
           let detailViewController = segue.destination as? DetailViewController {

            // Use the index path to get the associated track
            let item = items[indexPath.row]
//
//            // Set the track on the detail view controller
            detailViewController.thisItem = item
        }
    }
}

// MARK: Conform ResultsView to UITableViewDataSource

extension ResultsView: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items?.count ?? .zero
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =
      itemsTableView.dequeueReusableCell(withIdentifier: ItemCell.reusableId, for: indexPath)
      as! ItemCell
    let item = items[indexPath.item]
    cell.itemNameLabel.text = item.name
    cell.itemCategoriesLabel.text =
      item.categories == nil ? "No categories" : item.categories!.joined(separator: ", ")
    cell.closetItem = item
    return cell
  }

}
