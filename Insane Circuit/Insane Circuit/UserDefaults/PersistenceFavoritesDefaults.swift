//
//  PersistenceFavoritesDefaults.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 20/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

class Persistence {
    let defaults = UserDefaults.standard
    private var objects: [Int] = []
    private var key = "Favoritos"

    init() {
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey: key) as? Data {
            do {
                let taskData = try decoder.decode([Int].self, from: data)
                self.objects = taskData
            } catch {
                print("Error load persistence init: \(error.localizedDescription)")
            }
        }
    }

    func add(object: Int) {
        if self.objects.contains(object) {
            print("Object already exists in persistence")
        } else {
            self.objects.append(object)
            save()
        }
        
    }
    
    func remove(object: Int) {
        if self.objects.contains(object) {
            if let index = self.objects.firstIndex(of: object) {
                self.objects.remove(at: index)
                save()
            }
        } else {
            print("Object does not exist in persistence")
        }
    }

    func save() {
        let enconder = JSONEncoder()
        do {
            let data = try enconder.encode(objects)
            defaults.set(data, forKey: key)
        } catch {
            print("Error save persistence: \(error.localizedDescription)")
        }
    }
    
    func existObjetc(object: Int) -> Bool {
        self.objects.contains(object) == true ? true:false
    }
    
    func persistedObjects() -> [Int]? {
        var persistedObjects = [Int]()
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey: key) as? Data {
            do {
                let taskData = try decoder.decode([Int].self, from: data)
                persistedObjects = taskData
            } catch {
                print("Error load persisted objects: \(error.localizedDescription)")
            }
        }
        return persistedObjects.count == 0 ? nil : persistedObjects
    }
}
