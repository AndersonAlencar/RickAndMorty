//
//  CharactersCollectionViewCell.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 18/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    
    let manager = NetworkManager()
    
    lazy var nameCharacter: UILabel = {
        let nameCharacter = UILabel()
        nameCharacter.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameCharacter.adjustsFontSizeToFitWidth = true
        nameCharacter.textColor = .systemBlue
        nameCharacter.text = "Apenas Testando"
        nameCharacter.textColor = .white
        nameCharacter.translatesAutoresizingMaskIntoConstraints = false
        return nameCharacter
    }()
    
    lazy var locationCharacter: UILabel = {
        let locationCharacter = UILabel()
        locationCharacter.font = UIFont(name: "HelveticaNeue", size: 20)
        locationCharacter.adjustsFontSizeToFitWidth = true
        locationCharacter.textColor = .systemBlue
        locationCharacter.numberOfLines = 0
        locationCharacter.sizeToFit()
        locationCharacter.textColor = .white
        locationCharacter.text = "Apenas Testando"
        locationCharacter.translatesAutoresizingMaskIntoConstraints = false
        return locationCharacter
    }()
    
    lazy var characterImage: UIImageView = {
        let characterImage = UIImageView()
        characterImage.clipsToBounds = true
        characterImage.image = UIImage(named: "rick")
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        return characterImage
    }()
    
    func configureCell(character: Character, image: Data?) {
        self.nameCharacter.text = character.name.uppercased()
        self.locationCharacter.text = character.location.name
        if let image = image {
            self.characterImage.image = UIImage(data: image)
        }
        switch character.status {
            case "Alive":
                self.backgroundColor = .backgroundAliveColor
            default:
                self.backgroundColor = .backgroundDeadColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setUp()
    }
}

extension CharactersCollectionViewCell: ViewCode {
    func buildHierarchy() {
        self.addSubview(characterImage)
        self.addSubview(nameCharacter)
        self.addSubview(locationCharacter)
    }
    
    func setUpLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: topAnchor),
            characterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])

        NSLayoutConstraint.activate([
            nameCharacter.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 8),
            nameCharacter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameCharacter.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameCharacter.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            locationCharacter.topAnchor.constraint(equalTo: nameCharacter.bottomAnchor, constant: 5),
            locationCharacter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            locationCharacter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            locationCharacter.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15)
            //locationCharacter.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func aditionalConfigurations() {
        self.layer.masksToBounds = true
    }
}
