//
//  ZooDetailsController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 13..
//

import UIKit

class ZooDetailsController: UIViewController {

    @IBOutlet weak var zooImage: UIImageView!
    @IBOutlet weak var zooDetails: UITextView!
    
    var zooDetail: ZooInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zooImage.image = UIImage(named: zooDetail?.image ?? "")
        zooDetails.text = zooDetail?.info ?? ""
        title = zooDetail?.name ?? ""
       
    }
}
