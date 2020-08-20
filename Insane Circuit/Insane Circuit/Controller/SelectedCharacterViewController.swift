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
    
    lazy var selectedCharacterView: SelectedCharacterView = {
        let selectedCharacterView = SelectedCharacterView(frame: .zero, character: character!, imageCharacter: characterImage!)
        return selectedCharacterView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = selectedCharacterView
    }

}
