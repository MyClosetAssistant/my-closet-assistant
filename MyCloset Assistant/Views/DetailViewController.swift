//
//  DetailViewController.swift
//  MyCloset Assistant
//
//  Created by Violeta Robles on 5/5/23.
//

import Alamofire
import AlamofireImage
import UIKit

class DetailViewController: UIViewController {

  var thisItem: ClosetItem!
  
  @IBOutlet weak var itemImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var brandLabel: UILabel!
  @IBOutlet weak var sizeLabel: UILabel!
  
  @IBOutlet weak var notesLabel: UILabel!
  @IBOutlet weak var notesTextLabel: UILabel!
  
  private var imageDataRequest: DataRequest?

  override func viewDidLoad() {
    super.viewDidLoad()
    itemImageView.image = configureImage(with: thisItem)
    nameLabel.text = thisItem.name
    categoryLabel.text = thisItem.categories![0]
    brandLabel.text = thisItem.brand
    sizeLabel.text = thisItem.size
    if let notes = thisItem.notes {
      notesLabel.text = notes
    } else {
      notesLabel.isHidden = true
      notesTextLabel.isHidden = true
    }
  }
  
  func configureImage(with item: ClosetItem) -> UIImage? {
    var result: UIImage? = nil
    if let imageFile = item.imageFile,
        let imageUrl = imageFile.url {
        imageDataRequest = AF.request(imageUrl).responseImage { response in
            switch response.result {
            case .success(let image):
                result = image
            case .failure(let error):
                print("ERROR: Couldn't load image: \(error.localizedDescription)")
            }
        }
    }
    return result
  }

  @IBAction func deleteItem(_ sender: Any) {
    var i = 0
    User.fetchUpdatedUser(completion: { [thisItem] in
      var user = $0
      for item in user.closet! {
        if item.objectId == thisItem!.objectId {
          user.closet!.remove(at: i)
          break
        }
        i += 1
      }
      thisItem!.delete {
        switch $0 {
        case .success():
          print("INFO: Item deleted")
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    })
  }
  
  private func loadImageFromParseAnd(do callback: @escaping (UIImage) -> Void) {
    if let imageFile = thisItem.imageFile, let imageUrl = imageFile.url {
      _ = AF.request(imageUrl).responseImage { response in
        switch response.result {
        case .success(let image):
          callback(image)
        case .failure(let error):
          print("WARN: Couldn't load image: \(error.localizedDescription)")
        }
      }
    }
  }
}
