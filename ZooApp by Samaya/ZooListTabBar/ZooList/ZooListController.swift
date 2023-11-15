//
//  ZooListController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 07..
//

import UIKit
import RealmSwift

class ZooListController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var zooListCollection: UICollectionView!
    @IBOutlet weak var layoutChangeButton: UIButton!
    
    let realm = try! Realm()
    var helper = DataBase()
    var zooImage = [ZooInfo]()
    var zoo = [ZooInfo]()
    var zooEmpty: [ZooInfo] = []
    var isGrid = false
    var animalsList = [Animals]()
    var animals = [Animals]()
    var isButtonTapped = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.getFilePath()
        fetchItems()
        helper.registerCell(nibName: "ZooListCell", forCellWithReuseIdentifier: "ZooListCell", in: zooListCollection)
        fetchCategory()
        
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        let searchText = searchTextField.text ?? ""
        if searchText.isEmpty {
            zooImage = zoo
        } else {
            zooEmpty = zoo.filter { $0.name?.localizedCaseInsensitiveContains(searchText) == true }
            zooImage = zooEmpty
        }
        zooListCollection.reloadData()
    }
    
    @IBAction func changeLayoutButtonClicked(_ sender: Any) {
        
        isGrid.toggle()
        zooListCollection.reloadData()
        updateButtonAppearance()
    }
}

extension ZooListController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        zooImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooListCell", for: indexPath) as! ZooListCell
        cell.zooImage.image = UIImage(named: zooImage[indexPath.item].image ?? "")
        cell.zooName.text = zooImage[indexPath.item].name
        cell.tag = indexPath.item
        cell.delegate = self
        
        if let selectedAnimalName = zooImage[indexPath.item].name,
              realm.objects(MyFavorites.self).filter("zoo = %@", selectedAnimalName).first != nil {
               cell.isButtonTapped = false
           }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "ZooAnimalsListController") as! ZooAnimalsListController
        
        
        var tempAnimals = [Animals]()
        for animal in animals {
            
            if zooImage[indexPath.item].name ==  animal.ZooName {
                tempAnimals.append(animal)
            }
        }
        controller.animals = tempAnimals
        navigationController?.show(controller, sender: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isGrid {
            
            let cellWidth = (collectionView.bounds.width - 15) / 2
            return CGSize(width: cellWidth, height: cellWidth)
            
        } else {
            return CGSize(width: collectionView.bounds.width - 35 , height: 220)
        }
    }
}

extension ZooListController: ZooListCellDelegate {
    
    func didTapSaveButton(index: Int) {
        let selectedZooInfo = zooImage[index].name
        
        if let selectedZooName = selectedZooInfo {
            
            if let existingFavorite = realm.objects(MyFavorites.self).filter("zoo = %@", selectedZooName).first {
                try! realm.write {
                    realm.delete(existingFavorite)
                }
            } else {
                let newFavorite = MyFavorites()
                newFavorite.zoo = selectedZooName
                try! realm.write {
                    realm.add(newFavorite)
                    
                }
            }
            
        }
    }
}
extension ZooListController {
    func fetchItems() {
        zooImage.removeAll()
        let data = realm.objects(ZooInfo.self)
        zoo.append(contentsOf: data)
        zooImage = zoo
        zooListCollection.reloadData()
    }
    
    func fetchCategory(){
        animalsList.removeAll()
        let data = realm.objects(Animals.self)
        animals.append(contentsOf: data)
        zooListCollection.reloadData()
    }
    
    func updateButtonAppearance() {
        if isGrid {
            layoutChangeButton.setImage(UIImage(systemName: "list.triangle"), for: .normal)
        } else {
            layoutChangeButton.setImage(UIImage(systemName: "circle.grid.2x2"), for: .normal)
            
        }
    }
    
}
