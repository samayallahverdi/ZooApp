//
//  AnimalCategoryCell.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 07..
//

import UIKit

class AnimalCategoryCell: UICollectionViewCell {

    @IBOutlet weak var animalsNameLabel: UILabel!
    @IBOutlet weak var animalsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animalsNameLabel.layer.cornerRadius = 10
        animalsNameLabel.layer.masksToBounds = true
    }
    func cellConfig(image: String, name: String){
        animalsNameLabel.text = name
        animalsImage.image = UIImage(named: image)
    }
}
