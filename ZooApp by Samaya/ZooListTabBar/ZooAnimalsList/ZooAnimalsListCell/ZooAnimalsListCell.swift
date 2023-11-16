//
//  ZooAnimalsListCell.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 14..
//

import UIKit

protocol ZooAnimalsListCellDelegate: AnyObject {
    func didTapSaveButton(index: Int)
}

class ZooAnimalsListCell: UICollectionViewCell {
    
    @IBOutlet weak var animalsName: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var animalsImage: UIImageView!
    
    var delegate: ZooAnimalsListCellDelegate?
    
    var isButtonTapped = true {
        didSet {
            updateButtonAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateButtonAppearance()
    }
    func configCell(image: String, name: String){
        animalsName.text = name
        animalsImage.image = UIImage(named: image)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        isButtonTapped.toggle()
        delegate?.didTapSaveButton(index: self.tag)
    }
    func updateButtonAppearance() {
        if !isButtonTapped {
            saveButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
           
        } else {
            
            saveButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
