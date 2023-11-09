//
//  ZooListCell.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 07..
//

import UIKit

protocol ZooListCellDelegate: AnyObject {
    func didTapSaveButton(index: Int)
}

class ZooListCell: UICollectionViewCell {

    @IBOutlet weak var zooImage: UIImageView!
    @IBOutlet weak var zooName: UILabel!
    @IBOutlet weak var favoriteButoon: UIButton!
    
    
    var delegate: ZooListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        zooImage.contentMode = .scaleAspectFill
                zooImage.clipsToBounds = true
        
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        delegate?.didTapSaveButton(index: self.tag)
    }
}
