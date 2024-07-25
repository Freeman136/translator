//
//  StorageManager.swift
//  FirstProject
//
//  Created by Andrew on 05.07.2024.
//

import Foundation
import RealmSwift

final class StorageManager {
    
    
    
    private init() {
        let version: UInt64 = 1
        let configuration = Realm.Configuration(
            schemaVersion: version) { migration, oldSchemaVersion in
                // 1
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Word.className()) { oldObject, newObject in
                        newObject!["image"] = nil
                    }
                }
            }
        Realm.Configuration.defaultConfiguration = configuration
        
        realm = try! Realm()
        
    }
    
    static var shared: StorageManager = StorageManager()
    private let realm: Realm
    
    // get
    func getRealmData<T: Object>() -> [T] {
        let arrayWords = realm.objects(T.self)
        return Array(arrayWords)
    }
    //
    func getWords1<T>() -> [T] where T: Object {
        let arrayWords = realm.objects(T.self)
        return Array(arrayWords)
    }
    
    // add
    
    func add( _ object: Object) {
        try! realm.write({
            realm.add(object)
        })
    }
    
    
    
    // update
    func update<Result>(_ completion: () throws -> Result) {
        
        try! realm.write(completion)
    }
    
    // update
    func update( _ object: Object) {
        
        try! realm.write{
            realm.add(object, update: .modified)
        }
    }
    
    
    // delete
    
    func delete(word: Object) {
        
        try! realm.write{
            realm.delete(word)
        }
    }
    
    func printURL() {
        if let url = realm.configuration.fileURL {
            print(url)
        }
    }
    
}
