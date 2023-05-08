//
//  ItemCell.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/18/23.
//

import UIKit

class ItemCell: UITableViewCell {

  @IBOutlet weak var itemNameLabel: UILabel!
  @IBOutlet weak var itemCategoriesLabel: UILabel!
  var closetItem: ClosetItem!
  static let reusableId = "ItemCell"

  // MARK: Overrides

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

  }

}
