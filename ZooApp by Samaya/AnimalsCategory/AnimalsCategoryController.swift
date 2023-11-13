//
//  AnimalCategoryController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 07..
//

import UIKit
import RealmSwift

class AnimalsCategoryController: UIViewController {
    
    @IBOutlet weak var backgrounView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    
    
    let realm = try! Realm()
    var animalsCategory = [Category]()
    var animalOnlyCategory = [String]()
    var category = [Category]()
    var filteredAnimalsCategory: [Category] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
        CellRegistration()
      
        
        // in case of same category names need unique one
        for value in animalsCategory {
            if !(animalOnlyCategory.contains(value.categoryName ?? "")) {
                animalOnlyCategory.append(value.categoryName ?? "")
            }
        }
    }
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        let searchText = searchField.text ?? ""

            if searchText.isEmpty {
                animalsCategory = category
            } else {
                filteredAnimalsCategory = category.filter { $0.categoryName?.localizedCaseInsensitiveContains(searchText) == true }
                animalsCategory = filteredAnimalsCategory
            }

            let uniqueCategories = Set(animalsCategory.compactMap { $0.categoryName })
           animalOnlyCategory = Array(uniqueCategories)
            categoryCollection.reloadData()
    }
}

extension AnimalsCategoryController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animalOnlyCategory.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCategoryCell", for: indexPath) as! AnimalCategoryCell
        cell.animalsImage.image = UIImage(named: animalOnlyCategory[indexPath.item])
        cell.animalsNameLabel.text = animalOnlyCategory[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AnimalCategoryListController") as! AnimalCategoryListController
        for value in animalsCategory {
            if value.categoryName == animalOnlyCategory[indexPath.item] {
                controller.animalsInCategory.append(value)
            }
        }
        navigationController?.show(controller, sender: nil)
    }
}
extension AnimalsCategoryController {
    
    func fetchItems() {
        animalsCategory.removeAll()
        let data = realm.objects(Category.self)
        category.append(contentsOf: data)
        animalsCategory = category
        categoryCollection.reloadData()
    }
    
    func CellRegistration() {
        categoryCollection.register(UINib(nibName: "AnimalCategoryCell", bundle: nil), forCellWithReuseIdentifier: "AnimalCategoryCell")
        
    }
}
