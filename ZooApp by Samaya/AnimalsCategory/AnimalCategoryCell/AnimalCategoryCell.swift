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
        // Initialization code
        animalsNameLabel.layer.cornerRadius = 10
        animalsNameLabel.layer.masksToBounds = true
    }
   
}
