//
//  IntroController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 05..
//

import UIKit


class IntroController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getStartButtonClicked(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        navigationController?.show(controller, sender: nil)
        
    }
}
