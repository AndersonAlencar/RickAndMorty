//
//  DiscoverViewController.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 14/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    let manager = NetworkManager()

    var charactersAlive = [Character]()
    var charactersDead = [Character]()
    var charactersAlien = [Character]()
    
    var charactersImageAlive:[Data] = [Data]() {
        didSet {
            if charactersImageAlive.count%20 == 0 {
                charactersView.imagesAlive = charactersImageAlive
            } else {
                getImagesCharactersAlive(id: charactersAlive[charactersImageAlive.count].id)
            }
        }
    }
    
    var charactersImageDead = [Data]() {
        didSet {
            if charactersImageDead.count%20 == 0 {
                charactersView.imagesDead = charactersImageDead
            } else {
                getImagesCharactersDead(id: charactersDead[charactersImageDead.count].id)
            }
        }
    }

    var charactersImageAlien = [Data]() {
        didSet {
            if charactersImageAlien.count%20 == 0 {
                charactersView.imagesAlien = charactersImageAlien
            } else {
                getImagesCharactersAlien(id: charactersAlien[charactersImageAlien.count].id)
            }
        }
    }

    
    lazy var charactersView: CharactersView = {
        let charactersView = CharactersView()
        return charactersView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = charactersView
        navigationItem.title = "Discover Characters"
        

        manager.getCharactersAlive(page: 1) { (characterAlive, error) in
            if let error = error {
                print(error)
            } else {
                self.charactersAlive = characterAlive!.results
                self.charactersView.charactersAlive = self.charactersAlive
                self.getImagesCharactersAlive(id: self.charactersAlive.first!.id)
               
            }
        }
        
        manager.getCharactersDead(page: 1) { (characterDead, error) in
            if let error = error {
                print(error)
            } else {
                self.charactersDead = characterDead!.results
                self.charactersView.charactersDead = self.charactersDead
                self.getImagesCharactersDead(id: self.charactersDead.first!.id)
            }
        }
        
        manager.getCharactersAlien(page: 1) { (characterAlien, error) in
            if let error = error {
                print(error)
            } else {
                self.charactersAlien = characterAlien!.results
                self.charactersView.charactersAlien = self.charactersAlien
                self.getImagesCharactersAlien(id: self.charactersAlien.first!.id)
            }
        }
    }
    
    func getImagesCharactersAlive(id: Int) {
        manager.getCharacterImage(id: id) { (data, error) in
            if let error = error {
                print("DiscoverController: \(error)")
            } else {
                self.charactersImageAlive.append(data!)
            }
        }
    }
    
    func getImagesCharactersDead(id: Int) {
        manager.getCharacterImage(id: id) { (data, error) in
            if let error = error {
                print("DiscoverController: \(error)")
            } else {
                self.charactersImageDead.append(data!)
            }
        }
    }

    func getImagesCharactersAlien(id: Int) {
        manager.getCharacterImage(id: id) { (data, error) in
            if let error = error {
                print("DiscoverController: \(error)")
            } else {
                self.charactersImageAlien.append(data!)
            }
        }
    }

}
