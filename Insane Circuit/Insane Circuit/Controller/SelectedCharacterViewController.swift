//
//  SelectedCharacterViewController.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 20/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class SelectedCharacterViewController: UIViewController {

    var character: Character?
    var characterImage: Data?
    var referenceFavorite: FavoritesViewController?

    lazy var selectedCharacterView: SelectedCharacterView = {
        let selectedCharacterView = SelectedCharacterView(frame: .zero, character: character!, imageCharacter: characterImage!)
        return selectedCharacterView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = selectedCharacterView
        navigationItem.title = "Characters"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        let backbutton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backbutton
        navigationItem.leftBarButtonItem?.tintColor = .labelColor
        
        navigationController?.navigationBar.barTintColor = .backgroundBlueColor
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func back() {
        referenceFavorite?.viewWillAppear(true)
        self.dismiss(animated: true, completion: nil)
    }
}
