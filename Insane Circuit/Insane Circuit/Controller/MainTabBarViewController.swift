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
        self.view.tintColor = .green
        tabBar.barTintColor = .tabBarColor

        let discover = UINavigationController(rootViewController: DiscoverViewController())
        discover.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(named: "Discover2"),tag: 0)
        
        let seasons = UINavigationController(rootViewController: SeasonsViewController())
        seasons.tabBarItem = UITabBarItem(title: "Seasons", image: UIImage(named: "Episode"),tag: 1)

        let favorites = UINavigationController(rootViewController: FavoritesViewController())
        favorites.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "Favorite"),tag: 2)
        
        let tabBarList = [discover, seasons, favorites]
        viewControllers = tabBarList
        
        let manager = PersistenceCache()
        let reads = manager.read()
        print(reads)
        print("deu bom")
    }
}
