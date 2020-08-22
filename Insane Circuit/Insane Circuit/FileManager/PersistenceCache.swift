//
//  PersistenceFileManager.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 21/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation
import UIKit

struct PersistedCharacter: Codable {
    var character: Character
    var image: Data
}

struct DataBase: Codable {
    var charactersAlive: [PersistedCharacter]?
    var charactersDead: [PersistedCharacter]?
    var charactersAlien: [PersistedCharacter]?

}

class PersistenceCache {
        
//    func createDirectory(type: keyType ) {
//        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
//        let logsPath = documentsPath.appendingPathComponent("Characters")
//        print(logsPath!)
//        do {
//            try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
//        } catch let error as NSError {
//            print("Unable to create directory",error)
//        }
//    }
    
    func writeFileFromData(objects: [Character], imageObjects: [Data], type: KeyType) {
        if objects.count == imageObjects.count  && objects.count <= 20 {
            var objectsForPersist = [PersistedCharacter]()
            for (index,object) in objects.enumerated() {
                let component = PersistedCharacter(character: object, image: imageObjects[index])
                objectsForPersist.append(component)
            }
            var dataBase = read()
            switch type {
                case .alive:
                    dataBase.charactersAlive = objectsForPersist
                case .dead:
                    dataBase.charactersDead = objectsForPersist
                default:
                    dataBase.charactersAlien = objectsForPersist
            }
            //self.writeFile(object: dataBase)  PERAI DEOKFJKGSDKFSKDFSMGDFKMSGFDKSGKDGKFGSKDJFGKSJDFGKJSDGFKSGDKFJGSKDJGFKSGDFKSF
        }
    }
    
    func writeFile(object: DataBase, type: KeyType) {
        let file = "PersistedCharacters.plist"
        //var jsonString = ""
        do {
            let jsonData = try JSONEncoder().encode(object)
            //jsonString = String(data: jsonData, encoding: .utf8)!
             if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                 let fileURL = dir.appendingPathComponent(file)
                 //writing
                 do {
                     try jsonData.write(to: fileURL)
                     print("DEu bom")
                     //try jsonString.write(to: fileURL, atomically: false, encoding: .utf8)
                 } catch {
                     print("cant write…")
                 }
             }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() -> DataBase {
        var dataBase = DataBase(charactersAlive: nil, charactersDead: nil, charactersAlien: nil)
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file = "PersistedCharacters.plist"
            let fileURL = dir.appendingPathComponent(file)

            do {
                let data = try Data(contentsOf: fileURL)
                dataBase = try JSONDecoder().decode(DataBase.self, from: data)
            } catch {
                print("cant read… file not exist")
            }
        }
        return dataBase
    }
}

extension PersistenceCache {
    enum KeyType {
        case alive
        case dead
        case alien
    }
}
