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
                print("Alive")
            }
        }
        
        manager.getCharactersDead(page: 1) { (characterDead, error) in
            if let error = error {
                print(error)
            } else {
                self.charactersDead = characterDead!.results
                self.charactersView.charactersDead = self.charactersDead
                print("Dead")
            }
        }
        
        manager.getCharactersAlien(page: 1) { (characterAlien, error) in
            if let error = error {
                print(error)
            } else {
                self.charactersAlien = characterAlien!.results
                self.charactersView.charactersAlien = self.charactersAlien
                print("Alien")
            }
        }
    }

}
