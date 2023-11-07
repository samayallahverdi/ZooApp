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
    
    let realm = try! Realm()
    var zooImage = [ZooInfo]()
    var zoo = [ZooInfo]()
    var zooMain: [ZooInfo] = []
    var isGrid = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchItems()
        CellRegistration()
       
        
    }
   
    @IBAction func searchButtonAction(_ sender: Any) {
        let searchText = searchTextField.text ?? ""
           if searchText.isEmpty {
               zooImage = zoo
           } else {
               zooMain = zoo.filter { $0.name?.localizedCaseInsensitiveContains(searchText) == true }
               zooImage = zooMain
           }
           zooListCollection.reloadData()
       }
    @IBAction func changeLayoutButtonClicked(_ sender: Any) {

        isGrid.toggle()
          zooListCollection.reloadData()
    }
}

    

extension ZooListController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        zooImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooListCell", for: indexPath) as! ZooListCell
        cell.zooImage.image = UIImage(named: zooImage[indexPath.item].image ?? "")

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isGrid {
               
            let cellWidth = (collectionView.bounds.width ) / 2
            return CGSize(width: cellWidth, height: cellWidth)
            
           } else {
             return CGSize(width: collectionView.bounds.width - 15 , height: 220)
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
}
