//
//  LoginController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 05..
//

import UIKit
import RealmSwift


class LoginController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let realm = try! Realm()
    let helper = DataBase()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.getFilePath()
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            showLoginAlert(message: "Fields can't be empty")
            return
        }
        
        let user = realm.objects(User.self).filter("email == %@ AND password == %@", email, password).first
        if user != nil {
            
            UserDefaults.standard.setValue(true, forKey: "isLogged")
            
            let controller = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            navigationController?.show(controller, sender: nil)
        } else {
            showLoginAlert(message: "Invalid credentials")
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
        navigationController?.show(controller, sender: nil)
    }
}
extension LoginController {
    func showLoginAlert(message: String) {
        let alertController = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okButton)
        present(alertController, animated: true)
    }
}
