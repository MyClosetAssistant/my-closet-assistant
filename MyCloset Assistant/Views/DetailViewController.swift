//
//  DetailViewController.swift
//  MyCloset Assistant
//
//  Created by Violeta Robles on 5/5/23.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController {

    var thisItem: ClosetItem!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageFile = thisItem.imageFile, let imageUrl = imageFile.url {
            _ = AF.request(imageUrl).responseImage { [unowned self] response in
                switch response.result {
                case .success(let image):
                    DispatchQueue.main.async{self.itemImageView.image = image}
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }

        nameLabel.text = thisItem.name
        categoryLabel.text = thisItem.categories![0]
        brandLabel.text = thisItem.brand
        sizeLabel.text = thisItem.size
        notesLabel.text = thisItem.notes
    }
    
//    Delete Item function
        @IBAction func deleteItem(_ sender: Any) {
            var i = 0
            User.fetchUpdatedUser(completion: {[thisItem] in
                var user = $0
                for item in user.closet!
                {
                    if item.objectId == thisItem!.objectId
                    {
                        user.closet!.remove(at: i)
                        break
                    }
                    i += 1
                }
                thisItem!.delete{
                    switch $0
                    {
                        
                    case .success():
                        print("Item successfully deleted!")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            })
        }
    }
