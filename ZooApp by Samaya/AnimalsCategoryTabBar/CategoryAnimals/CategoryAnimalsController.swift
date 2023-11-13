//
//  CategoryAnimalsController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 13..
//

import UIKit

class CategoryAnimalsController: UIViewController {

    @IBOutlet weak var infoText: UITextView!
    @IBOutlet weak var animalsImage: UIImageView!
    
    var animalsInfo: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(animalsInfo ?? "")
        infoText.text = animalsInfo?.animalsInfo ?? ""
        animalsImage.image = UIImage(named: animalsInfo?.animalsImage ?? "")
        title = animalsInfo?.animalName
    }
    
}
