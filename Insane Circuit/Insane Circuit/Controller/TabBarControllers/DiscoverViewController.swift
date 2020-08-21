//
//  DiscoverViewController.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 14/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    // MARK: Variables of class

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
        charactersView.delegatePresentCharactersView = self
        charactersView.delegatePage = self
        return charactersView
    }()

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view = charactersView
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Discover Characters"
        
        getCharacters(page: 1, status: "alive")
        getCharacters(page: 1, status: "dead")
        getCharacters(page: 1, status: "alien")
    }
    
    func getCharacters(page: Int, status: String) {
        switch status {
            case "alive":
                manager.getCharactersAlive(page: page) { (characterAlive, error) in
                    if let error = error {
                        print(error)
                    } else {
                        self.charactersAlive.append(contentsOf: characterAlive!.results)
                        self.charactersView.charactersAlive = self.charactersAlive
                        self.getImagesCharactersAlive(id: self.charactersAlive[self.charactersAlive.count-20].id)
                    }
                }
            case "dead":
                manager.getCharactersDead(page: page) { (characterDead, error) in
                    if let error = error {
                        print(error)
                    } else {
                        self.charactersDead.append(contentsOf: characterDead!.results)
                        self.charactersView.charactersDead = self.charactersDead
                        self.getImagesCharactersDead(id: self.charactersDead[self.charactersDead.count-20].id)
                    }
                }
            default:
                manager.getCharactersAlien(page: page) { (characterAlien, error) in
                    if let error = error {
                        print(error)
                    } else {
                        self.charactersAlien.append(contentsOf: characterAlien!.results)
                        self.charactersView.charactersAlien = self.charactersAlien
                        self.getImagesCharactersAlien(id: self.charactersAlien[self.charactersAlien.count-20].id)
                    }
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

extension DiscoverViewController: RequestNewPageDelegate {
    func requestNewPageAPI(page: Int, status: String) {
        print("ok ele chamou page:\(page) e status: \(status)")
        getCharacters(page: page, status: status)
    }
}
