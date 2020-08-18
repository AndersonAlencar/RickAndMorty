//
//  MainTabBarViewController.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 14/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let discover = UINavigationController(rootViewController: DiscoverViewController())
        discover.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let seasons = UINavigationController(rootViewController: SeasonsViewController())
        seasons.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        
        let favorites = UINavigationController(rootViewController: FavoritesViewController())
        favorites.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let tabBarList = [discover, seasons, favorites]
        viewControllers = tabBarList
        
        let manager = NetworkManager()
        
        manager.getCharacterImage(id: 1){ (person, error) in
            print(person)
            print(error)
        }
    }
}
