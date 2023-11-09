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
    var data = DataBase()
    var zooImage = [ZooInfo]()
    var zoo = [ZooInfo]()
    var zooEmpty: [ZooInfo] = []
    var isGrid = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.getFilePath()
        fetchItems()
        CellRegistration()
        
        
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
        
        cell.delegate = self
        return cell
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
        let selectedZoo = zooImage[index]
//        let realm = try! Realm()
        
        if let existingFavorite = realm.objects(MyFavorites.self).filter("zoo = %@", selectedZoo.name ?? "").first {
            try! realm.write {
                realm.delete(existingFavorite)
            }
        } else {
            let newFavorite = MyFavorites()
            newFavorite.zoo = selectedZoo.name
            try! realm.write {
                realm.add(newFavorite)
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
    
    func CellRegistration() {
        zooListCollection.register(UINib(nibName: "ZooListCell", bundle: nil), forCellWithReuseIdentifier: "ZooListCell")
        
    }
    func updateButtonAppearance() {
        if isGrid {
            layoutChangeButton.setImage(UIImage(systemName: "list.triangle"), for: .normal)
        } else {
            layoutChangeButton.setImage(UIImage(systemName: "circle.grid.2x2"), for: .normal)
            
        }
    }
}
