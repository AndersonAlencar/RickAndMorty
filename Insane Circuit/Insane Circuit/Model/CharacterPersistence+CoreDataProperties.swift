//
//  CharacterPersistence+CoreDataProperties.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 04/02/21.
//  Copyright © 2021 Anderson Alencar. All rights reserved.
//
//

import Foundation
import CoreData


extension CharacterPersistence {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterPersistence> {
        return NSFetchRequest<CharacterPersistence>(entityName: "CharacterPersistence")
    }

    @NSManaged public var characterID: Int64

}

extension CharacterPersistence : Identifiable {

}
