//
//  ZooInfoController.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 08..
//

import UIKit
import RealmSwift

class ZooInfoController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var zooInfoCollection: UICollectionView!
    
    let realm = try! Realm()
    var zooInfo = [ZooInfo]()
    var zooOriginal = [ZooInfo]()
    var zooEmpty: [ZooInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
        CellRegistration()
        
    }
    

    @IBAction func searchButton(_ sender: Any) {
        let searchText = searchTextField.text ?? ""
        if searchText.isEmpty {
            zooInfo = zooOriginal
        } else {
            zooEmpty = zooOriginal.filter { $0.name?.localizedCaseInsensitiveContains(searchText) == true }
            zooInfo = zooEmpty
        }
        zooInfoCollection.reloadData()
    }
    

}
extension ZooInfoController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        zooInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooInfoCell", for: indexPath) as! ZooInfoCell
        cell.cellConfig(image: zooInfo[indexPath.item].image ?? "", title: zooInfo[indexPath.item].name ?? "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ZooDetailsController") as! ZooDetailsController
        controller.zooDetail = zooInfo[indexPath.item]
        navigationController?.show(controller, sender: nil)
    }
    
}
extension ZooInfoController {
    func fetchItems() {
        zooInfo.removeAll()
        let data = realm.objects(ZooInfo.self)
        zooOriginal.append(contentsOf: data)
        zooInfo = zooOriginal
        zooInfoCollection.reloadData()
    }
    
    func CellRegistration() {
        zooInfoCollection.register(UINib(nibName: "ZooInfoCell", bundle: nil), forCellWithReuseIdentifier: "ZooInfoCell")
        
    }
}
