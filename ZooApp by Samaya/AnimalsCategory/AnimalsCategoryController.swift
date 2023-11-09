//
//  AnimalCategoryController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 07..
//

import UIKit

class AnimalsCategoryController: UIViewController {

    @IBOutlet weak var backgrounView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
    }
    
    

}

//extension AnimalsCategoryController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//}
