//
//  FavoritesViewController.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 14/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    lazy var favoritesView: FavoritesView = {
        return FavoritesView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoritesView
    }
}
