//
//  ViewController.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/10/23.
//

import UIKit

class LoginView: UIViewController {

  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var usernameErrorLabel: UILabel!
  @IBOutlet weak var passwordErrorLabel: UILabel!
  @IBOutlet weak var loginErrorLabel: UILabel!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  let queue = DispatchQueue.global(qos: .userInitiated)

  // MARK: Overrides

  override func viewDidLoad() {
    super.viewDidLoad()
    loadingIndicator.isHidden = true
    loadingIndicator.layer.cornerRadius = 5
    usernameErrorLabel.isHidden = true
    passwordErrorLabel.isHidden = true
    loginErrorLabel.isHidden = true

    usernameField.delegate = self
    passwordField.delegate = self
  }

  @IBAction func onLoginTapped(_ sender: Any) {
    let username = usernameField!.text!
    let password = passwordField!.text!

    if username.isEmpty {
      usernameErrorLabel.text = "'Username' field must be filled out"
      showErrorLabel(for: &usernameErrorLabel)
    }
    if password.isEmpty {
      passwordErrorLabel.text = "'Password' field must be filled out"
      showErrorLabel(for: &passwordErrorLabel)
    }

    User.login(username: username, password: password) { [unowned self] result in
      if !username.isEmpty {
        self.hideErrorLabel(for: &usernameErrorLabel)
      }
      if !password.isEmpty {
        self.hideErrorLabel(for: &passwordErrorLabel)
      }

      switch result {
      case .success(let user):
        loadingIndicator.isHidden = false
        print("Logged in as user: \(user)")
        self.hideErrorLabel(for: &loginErrorLabel)
        queue.asyncAfter(
          deadline: .now() + 0.5,
          execute: {
            NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
          })
      case .failure(let error):
        self.loginErrorLabel.text = error.message.capitalized
        self.showErrorLabel(for: &self.loginErrorLabel)
      }
    }
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

// Conform LoginView to UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
