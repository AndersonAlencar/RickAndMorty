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

class PersistenceCache {
    
    let mypersistence = [PersistedCharacter(character: person, image: image),PersistedCharacter(character: person, image: image)]
    
    func createDirectory() {
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let logsPath = documentsPath.appendingPathComponent("Characters")
        print(logsPath!)
        do {
            try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Unable to create directory",error)
        }
    }
    
//    func writeFile(object: [PersistedCharacter]) {
//        let file = "PersistedCharacters.txt"
//        var jsonString = ""
//        do {
//            let jsonData = try JSONEncoder().encode(object)
//            jsonString = String(data: jsonData, encoding: .utf8)!
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//            let fileURL = dir.appendingPathComponent(file)
//            //writing
//            do {
//                try jsonString.write(to: fileURL, atomically: false, encoding: .utf8)
//            } catch {
//                print("cant write…")
//            }
//        }
//    }
    
    func writeFile(object: [PersistedCharacter]) {
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
    
    func read() -> [PersistedCharacter] {
        var objects = [PersistedCharacter]()
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file = "PersistedCharacters.plist"
            let fileURL = dir.appendingPathComponent(file)

            do {
                let data = try Data(contentsOf: fileURL)
                objects = try JSONDecoder().decode([PersistedCharacter].self, from: data)
            } catch {
                print("cant read…")
            }
        }
        return objects
    }
}
