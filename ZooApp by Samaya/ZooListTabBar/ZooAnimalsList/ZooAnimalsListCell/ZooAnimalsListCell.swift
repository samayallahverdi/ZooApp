//
//  ZooAnimalsListCell.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 14..
//

import UIKit

class ZooAnimalsListCell: UICollectionViewCell {

    @IBOutlet weak var animalsName: UILabel!
    @IBOutlet weak var animalsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configCell(image: String, name: String){
        animalsName.text = name
        animalsImage.image = UIImage(named: image)
    }
}
