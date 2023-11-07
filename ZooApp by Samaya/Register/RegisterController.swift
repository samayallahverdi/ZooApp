//
//  RegisterController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 07..
//

import UIKit
import RealmSwift

class RegisterController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var bithdateField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    let realm = try! Realm()
    let newUser = User()
    var helper = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helper.getFilePath()
    }
    
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        
        guard let name = nameField.text, !name.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let birthdate = bithdateField.text, !birthdate.isEmpty,
              let phoneNumber = numberField.text, !phoneNumber.isEmpty,
              let password = passwordField.text, !password.isEmpty
        else {
            showRegisterAlert(message: "Fields can't be empty")
            return
        }
        if !isValidEmail(email) {
            showRegisterAlert(message: "Invalid email format")
            return
        }
        if !isValidPassword(password) {
                showRegisterAlert(message: "Password must be at least 8 characters, one uppercase letter, one lowercase letter,one number")
                return
            }

        
        
        // User adding
        let success = addUserToRealm(name: name, email: email, birthdate: birthdate, phoneNumber: phoneNumber, password: password)
        
        if success {
           
            let controller = storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
            navigationController?.show(controller, sender: nil)
        } else {
            
            print("error")
        }
        
    }
    
}
extension RegisterController {
    
    func showRegisterAlert(message: String) {
        let alertController = UIAlertController(title: "Register Failed", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okButton)
        present(alertController, animated: true)
        
        
    }
    
    func addUserToRealm(name: String, email: String, birthdate: String, phoneNumber: String, password: String) -> Bool {
        
        
        newUser.name = name
        newUser.email = email
        newUser.birthdate = birthdate
        newUser.phoneNumber = phoneNumber
        newUser.password = password
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newUser)
            }
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
   
}

// Register Configuration

extension RegisterController {
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = #"(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}"#
        return NSPredicate(format:"SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format:"SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

