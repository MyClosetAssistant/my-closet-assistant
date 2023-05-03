//
//  UploadViewController.swift
//  MyCloset Assistant
//
//  Created by Violeta Robles on 5/2/23.
//

import PhotosUI
import UIKit

class UploadViewController: UIViewController {

  @IBOutlet weak var uploadImage: UIImageView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var categoryTextField: UITextField!
  @IBOutlet weak var brandTextField: UITextField!
  @IBOutlet weak var sizeTextField: UITextField!
  @IBOutlet weak var notesTextField: UITextField!

  @IBAction func tappedCamera(_ sender: Any) {
    print("Tapped Camera")
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      print("❌📷 Camera not available")
      return
    }

    // Instantiate the image picker
    let imagePicker = UIImagePickerController()

    // Shows the camera (vs the photo library)
    imagePicker.sourceType = .camera

    // Allows user to edit image within image picker flow (i.e. crop, etc.)
    // If you don't want to allow editing, you can leave out this line as the default value of `allowsEditing` is false
    imagePicker.allowsEditing = true

    // The image picker (camera in this case) will return captured photos via it's delegate method to it's assigned delegate.
    // Delegate assignee must conform and implement both `UIImagePickerControllerDelegate` and `UINavigationControllerDelegate`
    imagePicker.delegate = self

    // Present the image picker (camera)
    present(imagePicker, animated: true)

  }

  @IBAction func tappedGallery(_ sender: Any) {
    print("Tapped Gallery")
    // Create a configuration object
    var config = PHPickerConfiguration()

    // Set the filter to only show images as options (i.e. no videos, etc.).
    config.filter = .images

    // Request the original file format. Fastest method as it avoids transcoding.
    config.preferredAssetRepresentationMode = .current

    // Only allow 1 image to be selected at a time.
    config.selectionLimit = 1

    // Instantiate a picker, passing in the configuration.
    let picker = PHPickerViewController(configuration: config)

    // Set the picker delegate so we can receive whatever image the user picks.
    picker.delegate = self

    // Present the picker
    present(picker, animated: true)
  }

  @IBAction func tappedUpload(_ sender: Any) {
    // TODO: Make sure non-empty fields
    guard let name = nameTextField.text,
      // TODO: Image as ParseFile
      let size = sizeTextField.text,
      let notes = notesTextField.text,
      let brand = brandTextField.text,
      let category = categoryTextField.text
    else {
      return
    }

    var item = ClosetItem(name: name, image: nil, size: size, notes: notes)
    item.brand = brand
    item.categories = [category]
    item.save { result in
      switch result {
      case .success(_):
        print("Saved item.")
      case .failure(let error):
        print("Error: \(error.localizedDescription)")
      }
    }

  }
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    uploadImage.isHidden = true
  }

  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UploadViewController: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    // Dismiss the picker
    picker.dismiss(animated: true)

    // Make sure we have a non-nil item provider
    guard let provider = results.first?.itemProvider,
      // Make sure the provider can load a UIImage
      provider.canLoadObject(ofClass: UIImage.self)
    else { return }

    // Load a UIImage from the provider
    provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in

      // Make sure we can cast the returned object to a UIImage
      guard let image = object as? UIImage else {

        // ❌ Unable to cast to UIImage
        //              self?.showAlert()
        return
      }

      // Check for and handle any errors
      if let error = error {
        //              self?.showAlert(for: error)
        return
      } else {

        // UI updates (like setting image on image view) should be done on main thread
        DispatchQueue.main.async {

          // Set image on preview image view
          self?.uploadImage.image = image
          self?.uploadImage.isHidden = false

          // Set image to use when saving post
          //                 self?.uploadImage = image
        }
      }
    }
  }
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
  ) {

    // Dismiss the image picker
    picker.dismiss(animated: true)

    // Get the edited image from the info dictionary (if `allowsEditing = true` for image picker config).
    // Alternatively, to get the original image, use the `.originalImage` InfoKey instead.
    guard let image = info[.editedImage] as? UIImage else {
      print("❌📷 Unable to get image")
      return
    }

    // Set image on preview image view
    uploadImage.image = image

    // Set image to use when saving post
    //        pickedImage = image
  }
}
