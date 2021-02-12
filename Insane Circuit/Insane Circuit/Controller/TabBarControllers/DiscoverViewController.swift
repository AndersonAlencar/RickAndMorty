//
//  DiscoverViewController.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 14/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    var waitLoadReference: WaitLoadViewController?

    // MARK: cache
    let managerCache = PersistenceCache()

    // MARK: Variables of class

    let managerNetwork = NetworkManager()
    var charactersAlive = [Character]()
    var charactersDead = [Character]()
    var charactersAlien = [Character]()
    
    var charactersImageAlive:[Data] = [Data]() {
        didSet {
            if charactersImageAlive.count % 20 == 0 {
                charactersView.charactersAlive = charactersAlive
                charactersView.imagesAlive = charactersImageAlive
                managerCache.writeFileFromData(objects: charactersAlive, imageObjects: charactersImageAlive, type: .alive)
                ifLoadComplete()
            } else {
                if Reachability.isConnectedToNetwork() {
                    getImagesCharactersAlive(id: charactersAlive[charactersImageAlive.count].id)
                    print("Internet Connection Available!")
                }
            }
        }
    }
    
    var charactersImageDead = [Data]() {
        didSet {
            if charactersImageDead.count % 20 == 0 {
                charactersView.charactersDead = charactersDead
                charactersView.imagesDead = charactersImageDead
                managerCache.writeFileFromData(objects: charactersDead, imageObjects: charactersImageDead, type: .dead)
                ifLoadComplete()
            } else {
                if Reachability.isConnectedToNetwork() {
                    getImagesCharactersDead(id: charactersDead[charactersImageDead.count].id)
                }
            }
        }
    }

    var charactersImageAlien = [Data]() {
        didSet {
            if charactersImageAlien.count % 20 == 0 {
                charactersView.charactersAlien = charactersAlien
                charactersView.imagesAlien = charactersImageAlien
                managerCache.writeFileFromData(objects: charactersAlien, imageObjects: charactersImageAlien, type: .alien)
                ifLoadComplete()
            } else {
                if Reachability.isConnectedToNetwork() {
                    getImagesCharactersAlien(id: charactersAlien[charactersImageAlien.count].id)
                }
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
        navigationController?.navigationBar.barTintColor = UIColor.backgroundBlueColor
        navigationController?.navigationBar.backgroundColor = UIColor.backgroundBlueColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.isTranslucent = false

        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Discover Characters"

        getCharacters(page: 1, status: "alive")
        getCharacters(page: 1, status: "dead")
        getCharacters(page: 1, status: "alien")
    }
    
     func getCharacters(page: Int, status: String) {
        let dataCache = managerCache.read()
        switch status {
            case "alive":
                managerNetwork.getCharactersAlive(page: page) { (characterAlive, error) in
                    if let error = error {
                        print("Get API Characters Alive: \(error)")
                        if let charactersAlive = dataCache.charactersAlive {
                            for characterData in charactersAlive {
                                self.charactersAlive.append(characterData.character)
                                self.charactersImageAlive.append(characterData.image)
                            }
                        }
                    } else {
                        self.charactersAlive.append(contentsOf: characterAlive!.results)
                        self.charactersView.charactersAlive = self.charactersAlive
                        self.getImagesCharactersAlive(id: self.charactersAlive[self.charactersAlive.count-20].id)
                    }
                }
            case "dead":
                managerNetwork.getCharactersDead(page: page) { (characterDead, error) in
                    if let error = error {
                        print("Get API Characters Dead: \(error)")
                        if let charactersAlive = dataCache.charactersDead {
                            for characterData in charactersAlive {
                                self.charactersDead.append(characterData.character)
                                self.charactersImageDead.append(characterData.image)
                            }
                        }
                    } else {
                        self.charactersDead.append(contentsOf: characterDead!.results)
                        self.charactersView.charactersDead = self.charactersDead
                        self.getImagesCharactersDead(id: self.charactersDead[self.charactersDead.count-20].id)
                    }
                }
            default:
                managerNetwork.getCharactersAlien(page: page) { (characterAlien, error) in
                    if let error = error {
                        print("Get API Characters Alien: \(error)")
                        if let charactersAlive = dataCache.charactersAlien {
                            for characterData in charactersAlive {
                                self.charactersAlien.append(characterData.character)
                                self.charactersImageAlien.append(characterData.image)
                            }
                        }
                    } else {
                        self.charactersAlien.append(contentsOf: characterAlien!.results)
                        self.charactersView.charactersAlien = self.charactersAlien
                        self.getImagesCharactersAlien(id: self.charactersAlien[self.charactersAlien.count-20].id)
                    }
                }
        }
    }
    
    func getImagesCharactersAlive(id: Int) {
        managerNetwork.getCharacterImage(id: id) { (data, error) in
            if let error = error {
                print("DiscoverController: \(error)")
            } else {
                self.charactersImageAlive.append(data!)
            }
        }
    }
    
    func getImagesCharactersDead(id: Int) {
        managerNetwork.getCharacterImage(id: id) { (data, error) in
            if let error = error {
                print("DiscoverController: \(error)")
            } else {
                self.charactersImageDead.append(data!)
            }
        }
    }

    func getImagesCharactersAlien(id: Int) {
        managerNetwork.getCharacterImage(id: id) { (data, error) in
            if let error = error {
                print("DiscoverController: \(error)")
            } else {
                self.charactersImageAlien.append(data!)
            }
        }
    }
    
    func ifLoadComplete() {
        if charactersImageDead.count == 20 && charactersImageAlive.count == 20 && charactersImageAlien.count == 20 {
            waitLoadReference?.viewModel.presentDiscoverController()
        }
    }

}

extension DiscoverViewController: RequestNewPageDelegate {
    func requestNewPageAPI(page: Int, status: String) {
        //print("ok ele chamou page:\(page) e status: \(status)")
        getCharacters(page: page, status: status)
    }
}
