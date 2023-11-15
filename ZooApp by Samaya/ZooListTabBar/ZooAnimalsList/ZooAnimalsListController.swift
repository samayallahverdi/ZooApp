//
//  ZooAnimalsListController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 13..
//

import UIKit
import RealmSwift

class ZooAnimalsListController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var animalsListCollection: UICollectionView!
    
    var helper = DataBase()
    let realm = try! Realm()
    var animals: [Animals] = []
    var animalsList = [Animals]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.registerCell(nibName: "ZooAnimalsListCell", forCellWithReuseIdentifier: "ZooAnimalsListCell", in: animalsListCollection)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let searchText = searchTextField.text ?? ""
        
        if searchText.isEmpty {
            animals = animalsList
        } else {
            let filteredAnimals = animalsList.filter { $0.AnimalsName?.localizedCaseInsensitiveContains(searchText) == true }
            animals = filteredAnimals
        }
        animalsListCollection.reloadData()
        
    }
}
extension ZooAnimalsListController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animals.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooAnimalsListCell", for: indexPath) as! ZooAnimalsListCell
        cell.configCell(image: animals[indexPath.item].image ?? "", name: animals[indexPath.item].AnimalsName ?? "")
        title = animals[indexPath.item].ZooName
        cell.delegate = self
        cell.tag = indexPath.item
        
        if let selectedAnimalName = animals[indexPath.item].AnimalsName,
              realm.objects(MyFavorites.self).filter("animals = %@", selectedAnimalName).first != nil {
               cell.isButtonTapped = false
           }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ZooAnimalsDetailsController") as! ZooAnimalsDetailsController
        controller.details = animals[indexPath.item]
        navigationController?.show(controller, sender: nil)
    }
    
}
extension ZooAnimalsListController: ZooAnimalsListCellDelegate {
    func didTapSaveButton(index: Int) {
        let selectedAnimalsInfo = animals[index].AnimalsName
        
        if let selectedAnimalName = selectedAnimalsInfo {
            
            if let existingFavorite = realm.objects(MyFavorites.self).filter("animals = %@", selectedAnimalName).first {
                try! realm.write {
                    realm.delete(existingFavorite)
                }
            } else {
                let newFavorite = MyFavorites()
                newFavorite.animals = selectedAnimalName
                try! realm.write {
                    realm.add(newFavorite)
                    
                }
            }
            
        }
    }
    
}
