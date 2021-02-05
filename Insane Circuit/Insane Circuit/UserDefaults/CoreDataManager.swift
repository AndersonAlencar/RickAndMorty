//
//  CoreDataManager.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 04/02/21.
//  Copyright © 2021 Anderson Alencar. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "InsaneCircuit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = CoreDataManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchFavoriteCharacters() -> [CharacterPersistence]? {
        var charaters: [CharacterPersistence]?
        let context = CoreDataManager.persistentContainer.viewContext
        do {
            let resultRequest = try context.fetch(CharacterPersistence.fetchRequest()) as? [CharacterPersistence]
            charaters = resultRequest
        } catch {
            print(error.localizedDescription)
        }
        return charaters
    }
    
    func fetchFavoriteCharactersID() -> [Int]? {
        var charaters: [Int]?
        let context = CoreDataManager.persistentContainer.viewContext
        do {
            let resultRequest = try context.fetch(CharacterPersistence.fetchRequest()) as? [CharacterPersistence]
            charaters = resultRequest!.map({ (character) -> Int in
                let id = Double(character.characterID)
                return Int(id)
            })
        } catch {
            print(error.localizedDescription)
        }
        return charaters
    }
    
    func saveNewCharacterFavorite(characaterID: Int64) {
        let context = CoreDataManager.persistentContainer.viewContext
        let newCharacter = CharacterPersistence(context: context)
        newCharacter.characterID = characaterID
        saveContext()
    }
    
    func removeCharacterFavorite(characaterID: Int64) {
        let context = CoreDataManager.persistentContainer.viewContext
        let arrayCharacters = self.fetchFavoriteCharacters()
        let character = arrayCharacters?.filter({ (character) -> Bool in
            character.characterID == characaterID
        }).first
        context.delete(character!)
        saveContext()
    }
    
    func characterIsPersisted(at id: Int) -> Bool {
        if let characters = fetchFavoriteCharactersID() {
            return characters.contains(id)
        }
        return false
    }
}
