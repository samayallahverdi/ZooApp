//
//  ZooAnimalsDetailsController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 13..
//

import UIKit

class ZooAnimalsDetailsController: UIViewController {
    
    @IBOutlet weak var animalsImage: UIImageView!
    @IBOutlet weak var infoTextView: UITextView!
    
    var details: Animals?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(details ?? "")
        
        animalsImage.image = UIImage(named: details?.image ?? "")
        infoTextView.text = details?.info ?? ""
    }
    

  
}
