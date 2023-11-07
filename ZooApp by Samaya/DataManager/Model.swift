//
//  Model.swift
//  ZooApp by Samaya
//
//  Created by BUDLCIT on 2023. 11. 05..
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted var name: String?
    @Persisted var email: String?
    @Persisted var birthdate: String?
    @Persisted var phoneNumber: String?
    @Persisted var password: String? 
}

class ZooInfo: Object {
    @Persisted var name: String?
    @Persisted var image: String?
    @Persisted var info: String?
}

class Animals: Object {
    @Persisted var ZooName: String?
    @Persisted var ZooImage: String?
    @Persisted var AnimalsName: String?
    @Persisted var image: String?
    @Persisted var info: String?
}

class Category: Object {
    @Persisted var categoryName: String?
    @Persisted var animalName: String?
    @Persisted var categoryImage: String?
    @Persisted var animalsImage: String?
    @Persisted var animalsInfo: String?
    @Persisted var categoryInfo: String?
}
