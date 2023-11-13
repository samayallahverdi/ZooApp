//
//  ZooInfoCellCell.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 13..
//

import UIKit

class ZooInfoCell: UICollectionViewCell {

    @IBOutlet weak var zooName: UILabel!
    @IBOutlet weak var zooImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func cellConfig(image: String, title: String){
        zooName.text = title
        zooImage.image = UIImage(named: image)
    }
    
    
}
