//
//  AnimalCategoryListController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 09..
//

import UIKit
import RealmSwift

class AnimalCategoryListController: UIViewController {
    
    @IBOutlet weak var backgroundViewColor: UIView!
    
    @IBOutlet weak var listCollection: UICollectionView!
    
    let realm = try! Realm()
    var animalsInCategory = [Category]()
    var category = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(animalsInCategory)
//       fetchItems()
        CellRegistration()
    }
}
extension AnimalCategoryListController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animalsInCategory.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalsCategoryListCell", for: indexPath) as! AnimalsCategoryListCell
        cell.animalsListImage.image = UIImage(named: animalsInCategory[indexPath.item].animalsImage ?? "")
        cell.animalsListName.text = animalsInCategory[indexPath.item].animalName
        return cell
    }
    
}

extension AnimalCategoryListController {
   
        func CellRegistration() {
            listCollection.register(UINib(nibName: "AnimalsCategoryListCell", bundle: nil), forCellWithReuseIdentifier: "AnimalsCategoryListCell")
        }
    }

