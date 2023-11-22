//
//  Helper.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 22..
//

import Foundation
import UIKit

class Helper {
    func registerCell(nibName: String, forCellWithReuseIdentifier identifier: String, in collectionView: UICollectionView){
   collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier)
}
}
