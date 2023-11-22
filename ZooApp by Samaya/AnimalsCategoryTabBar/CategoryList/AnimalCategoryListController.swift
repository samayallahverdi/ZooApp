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
    var helper = Helper()
    var animalsInCategory = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.registerCell(nibName: "AnimalsCategoryListCell", forCellWithReuseIdentifier: "AnimalsCategoryListCell", in: listCollection)
        
    }
}
extension AnimalCategoryListController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animalsInCategory.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalsCategoryListCell", for: indexPath) as! AnimalsCategoryListCell
        cell.cellConfig(image: animalsInCategory[indexPath.item].animalsImage ?? "", name: animalsInCategory[indexPath.item].animalName ?? "")
        title = animalsInCategory[indexPath.item].categoryName
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CategoryAnimalsController") as! CategoryAnimalsController
        controller.animalsInfo = animalsInCategory[indexPath.item]
        navigationController?.show(controller, sender: nil)
    }
}

