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
        let backbutton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backbutton
        navigationItem.leftBarButtonItem?.tintColor = .labelColor
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
}

//class Persistence {
//    let defaults = UserDefaults.standard
//    var objects: Set<String> = []
//    private var key = "Favoritos"
//    
//    init() {
//        let decoder = JSONDecoder()
//        if let data = defaults.value(forKey: key) as? Data {
//            do {
//                let taskData = try decoder.decode(Set<String>.self, from: data)
//                self.objects = taskData
//            } catch {
//                print("Deu merda no init: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func add(object: String) {
//        self.objects.insert(object)
//        //save()
//    }
//    
//    func save() {
//        let enconder = JSONEncoder()
//        do {
//            let data = try enconder.encode(objects)
//            defaults.set(data, forKey: key)
//        } catch {
//            print("Deu merda no save: \(error.localizedDescription)")
//        }
//    }
//}
