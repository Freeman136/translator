//
//  Words.swift
//  FirstProject
//
//  Created by Andrew on 08.05.2024.
//

import UIKit
import RealmSwift

class Word: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var my: String
    @Persisted var learn: String
    @Persisted var image: Data?
    
    convenience init(my: String, learn: String, image: Data?) {
        self.init()
        self.my = my
        self.learn = learn
        self.image = image
    }
}


