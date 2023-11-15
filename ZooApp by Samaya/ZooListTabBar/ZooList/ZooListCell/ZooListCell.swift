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
    
    var isButtonTapped = true {
            didSet {
                updateButtonAppearance()
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        zooImage.contentMode = .scaleAspectFill
                zooImage.clipsToBounds = true
    
    }
    func updateButtonAppearance() {
          if !isButtonTapped {
             
              favoriteButoon.backgroundColor = UIColor.yellow
          } else {
              
              favoriteButoon.backgroundColor = UIColor.clear
          }
      }

    @IBAction func saveButtonTapped(_ sender: Any) {
        isButtonTapped.toggle()
        delegate?.didTapSaveButton(index: self.tag)
        print(self.tag)
        
    }
}
