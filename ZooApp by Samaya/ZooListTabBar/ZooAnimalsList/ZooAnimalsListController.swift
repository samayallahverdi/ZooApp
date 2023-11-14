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
    
    let realm = try! Realm()
    var animals: [Animals] = []
    var animalsList = [Animals]()
    var empty : [Animals] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       
       CellRegistration()
        fetchAnimals()
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ZooAnimalsDetailsController") as! ZooAnimalsDetailsController
        controller.details = animals[indexPath.item]
        navigationController?.show(controller, sender: nil)
    }
    
}
extension ZooAnimalsListController {
    func CellRegistration() {
        animalsListCollection.register(UINib(nibName: "ZooAnimalsListCell", bundle: nil), forCellWithReuseIdentifier: "ZooAnimalsListCell")
    }
    
    func fetchAnimals(){
        animals.removeAll()
        let data = realm.objects(Animals.self)
        animals.append(contentsOf: data)
        animalsList = Array(animals)
        animalsListCollection.reloadData()
    }
}
