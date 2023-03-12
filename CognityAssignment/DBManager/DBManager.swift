//
//  DBManager.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 12/3/23.
//

import Foundation
import Realm
import RealmSwift

class DBManager:NSObject{
    var realm:Realm?
    
    override init() {
            super.init()
            var config = Realm.Configuration()

                   config.fileURL = config

                       .fileURL!

                       .deletingLastPathComponent()

                       .appendingPathComponent("userdata.realm")

                   config.schemaVersion = 56

                   config.migrationBlock = { _, oldSchemaVersion in

                       if oldSchemaVersion < 1 {}

                   }
                   do {

                       realm = try Realm(configuration: config)

                   } catch let error as NSError {

                       print(error)

                   }
        
    }

    func insertRecord(dbStruct:DBStruct) {
        do{
            realm?.beginWrite()
            realm?.add(dbStruct)
            try realm?.commitWrite()
        }
        catch{
            debugPrint("database error with login something went wrong!!!")
        }
    }


    func fetchRecord() -> Results<DBStruct> {
        return (realm?.objects(DBStruct.self))!
    }
    
   
  
   
}
