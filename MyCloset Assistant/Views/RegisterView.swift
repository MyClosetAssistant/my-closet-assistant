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
    
    var userGender: Gender? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Customize the appearance of the pullDownButton
        genderButton.layer.cornerRadius = 5
        genderButton.layer.borderWidth = 0.5
        genderButton.layer.borderColor = UIColor.systemGray4.cgColor
        let menuClosure = {(action: UIAction) in
                   
               self.update(number: action.title)
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
    
    func update(number:String) {
        if number == "  \(Gender.other)" {
         userGender =  .other
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

        // Make sure all fields are non-nil and non-empty.
        guard let username = usernameField.text,
              let email = emailField.text,
              let gender = userGender,
              let password = passwordField.text,
              !username.isEmpty,
              !email.isEmpty,
//              !gender.isEmpty,
              !password.isEmpty else {

            showMissingFieldsAlert()
            return
        }

        // TODO: Pt 1 - Parse user sign up
        var newUser = User()
        newUser.username = username
        newUser.email = email
        newUser.password = password
        newUser.gender = gender
        newUser.signup { [weak self] result in

            switch result {
            case .success(let user):

                print("✅ Successfully signed up user \(user)")

                // Post a notification that the user has successfully signed up.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)

            case .failure(let error):
                // Failed sign up
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Sign Up", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to sign you up.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    
}
