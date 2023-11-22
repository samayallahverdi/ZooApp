//
//  DataBase.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 05..
//

import Foundation
import RealmSwift
import UIKit

class DataBase {
    let realm = try! Realm()
    func getFilePath() {
        if let url = realm.configuration.fileURL {
            print(url)
        }
    }
    
}

