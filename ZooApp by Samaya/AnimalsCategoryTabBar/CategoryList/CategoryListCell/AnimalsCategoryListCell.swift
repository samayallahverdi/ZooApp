//
//  AnimalsCategoryListCell.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 09..
//

import UIKit

class AnimalsCategoryListCell: UICollectionViewCell {

    @IBOutlet weak var animalsListName: UILabel!
    @IBOutlet weak var animalsListImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func cellConfig(image: String, name: String){
        animalsListName.text = name
        animalsListImage.image = UIImage(named: image)
    }
}
