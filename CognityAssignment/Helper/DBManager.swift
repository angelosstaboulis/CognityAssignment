//
//  DBManager.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 11/2/24.
//

import Foundation
import Realm
import RealmSwift
class DBManager{
    var realm:Realm!
    init(){
        var config = Realm.Configuration()

           config.fileURL = config

               .fileURL!

               .deletingLastPathComponent()

               .appendingPathComponent("cognity.realm")
       
     

           config.schemaVersion = 59

           config.migrationBlock = { _, oldSchemaVersion in

               if oldSchemaVersion < 1 {}
           }
        do{
            realm = try Realm(configuration: config)
        }
        catch{
            
        }
    }
    func insertRecord(dbStruct:DBStruct) {
               try! realm?.write{
                   realm?.create(DBStruct.self,value:dbStruct,update: .all)
               }

    }
    func fetchRecords()->Results<DBStruct>{
       
        return (realm?.objects(DBStruct.self))!
    }
    
}
