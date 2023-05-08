//
//  RegisterView.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/13/23.
//

import UIKit

class RegisterView: UIViewController {

  @IBOutlet weak var genderButton: UIButton!
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var usernameErrorLabel: UILabel!
  @IBOutlet weak var emailErrorLabel: UILabel!
  @IBOutlet weak var genderErrorLabel: UILabel!
  @IBOutlet weak var passwordErrorLabel: UILabel!
  @IBOutlet weak var registerErrorLabel: UILabel!
  var userGender: Gender? = nil
  let queue = DispatchQueue.global(qos: .userInitiated)

  // MARK: Overrides

  override func viewDidLoad() {
    super.viewDidLoad()

    usernameErrorLabel.isHidden = true
    emailErrorLabel.isHidden = true
    genderErrorLabel.isHidden = true
    passwordErrorLabel.isHidden = true
    registerErrorLabel.isHidden = true
    usernameField.delegate = self
    emailField.delegate = self
    passwordField.delegate = self

    genderButton.layer.cornerRadius = 5
    genderButton.layer.borderWidth = 0.5
    genderButton.layer.borderColor = UIColor.systemGray4.cgColor
    let menuClosure = { (action: UIAction) in
      self.updateGenderSelection(number: action.title)
    }
    genderButton.menu = UIMenu(children: [
      UIAction(title: "  select gender", state: .on, handler: menuClosure),
      UIAction(title: "  \(Gender.other)", handler: menuClosure),
      UIAction(title: "  \(Gender.male)", handler: menuClosure),
      UIAction(title: "  \(Gender.female)", handler: menuClosure),
    ])
    genderButton.showsMenuAsPrimaryAction = true
    genderButton.changesSelectionAsPrimaryAction = true
  }

  func updateGenderSelection(number: String) {
    if number == "  \(Gender.other)" {
      userGender = .other
      print("other selected")
    }
    if number == "  \(Gender.female)" {
      userGender = .female
      print("female selected")
    }
    if number == "  \(Gender.male)" {
      userGender = .male
      print("male selected")
    }
    if number == "  select gender" {
      userGender = nil
      print("make a selection")
    }
  }

  @IBAction func OnRegisterTapped(_ sender: Any) {
    print("INFO: Tapped on Register")

    let username = usernameField.text!
    let email = emailField.text!
    let password = passwordField.text!

    if username.isEmpty {
      usernameErrorLabel.text = "'Username' field must be filled out"
      showErrorLabel(for: &usernameErrorLabel)
    } else {
      hideErrorLabel(for: &usernameErrorLabel)
    }
    if email.isEmpty {
      emailErrorLabel.text = "'Email' field must be filled out"
      showErrorLabel(for: &emailErrorLabel)
    } else {
      hideErrorLabel(for: &emailErrorLabel)
    }
    if password.isEmpty {
      passwordErrorLabel.text = "'Password' field must be filled out"
      showErrorLabel(for: &passwordErrorLabel)
    } else {
      hideErrorLabel(for: &passwordErrorLabel)
    }
    if userGender == nil {
      genderErrorLabel.text = "You must select a gender"
      showErrorLabel(for: &genderErrorLabel)
      return
    } else {
      hideErrorLabel(for: &genderErrorLabel)
    }

    let newUser = User(username: username, email: email, password: password, gender: userGender!)
    newUser.signup { [unowned self] result in
      switch result {
      case .success(let user):
        print("INFO: Signed up user: \(user.username!)")
        self.hideErrorLabel(for: &registerErrorLabel)
        queue.asyncAfter(
          deadline: .now() + 0.5,
          execute: {
            NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
          })
      case .failure(let error):
        print("FATAL: Couldn't signup: \(error.localizedDescription)")
        self.registerErrorLabel.text = error.message.capitalized
        self.showErrorLabel(for: &self.registerErrorLabel)
      }
    }

  }

  @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true)
  }

  // MARK: Private Helpers

  private func showErrorLabel(for label: inout UILabel) {
    UILabel.transition(
      with: label, duration: 0.33, options: [.transitionCrossDissolve],
      animations: { [label] in
        label.isHidden = false
      })
  }

  private func hideErrorLabel(for label: inout UILabel) {
    UILabel.animate(
      withDuration: 0.33,
      animations: { [label] in
        label.isHidden = true
      })
  }

}

// Conform RegisterView to UITextFieldDelegate
extension RegisterView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
