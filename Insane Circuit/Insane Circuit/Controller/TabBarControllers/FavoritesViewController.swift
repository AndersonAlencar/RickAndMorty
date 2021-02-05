//
//  FavoritesViewController.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 14/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let coredatamanager = CoreDataManager()
    
    let manager = NetworkManager()
    
    var charactersFavorites = [Character]() {
        didSet {
            favoritesView.characters = charactersFavorites
            getImage(id: charactersFavorites.first!.id)
        }
    }
    
    var imagesFavorites = [Data]() {
        didSet {
            if imagesFavorites.count < charactersFavorites.count {
                getImage(id: charactersFavorites[imagesFavorites.count].id)
            } else {
                favoritesView.imagesCharacters = imagesFavorites
                imagesFavorites.removeAll()  // garante que ele não use appende para adicionar imagens repetidas
            }
        }
    }

    lazy var favoritesView: FavoritesView = {
        let favoritesView = FavoritesView()
        favoritesView.presentCharacterDelegate = self
        return favoritesView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoritesView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let charactersFavoritesIDs = coredatamanager.fetchFavoriteCharactersID() {
            if charactersFavoritesIDs.count == 1 {
                manager.getCharacter(id: charactersFavoritesIDs.first!) { (character, error) in
                    if let error = error {
                        print("Error request: \(error)")
                    } else {
                        self.charactersFavorites.append(character!)
                    }
                }
            } else {
                manager.getFavoritesCharacters(ids: charactersFavoritesIDs) { (characters, error) in
                    if let error = error {
                        print("Error request: \(error)")
                    } else {
                        self.charactersFavorites = characters!
                    }
                }
            }
        }
    }
    
    func getImage(id: Int) {
        manager.getCharacterImage(id: id) { (data, error) in
            if let error = error {
                print("Error Request Image: \(error) ")
            } else {
                self.imagesFavorites.append(data!)
            }
        }
    }
}
