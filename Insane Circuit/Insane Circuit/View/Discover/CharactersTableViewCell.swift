//
//  CharactersTableViewCell.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 18/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    var characters: [Character] = [Character]() {
        didSet {
            self.collectionCharacters.reloadData()
        }
    }
    
    var colorCell: UIColor?
    
    lazy var collectionCharacters: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionCharacters = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionCharacters.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionCharacters.backgroundColor = .backgroundBlueColor
        collectionCharacters.showsHorizontalScrollIndicator = false//
        collectionCharacters.isPagingEnabled = true//
        collectionCharacters.contentInsetAdjustmentBehavior = .never//
        collectionCharacters.collectionViewLayout = flowLayout
        collectionCharacters.delegate = self
        collectionCharacters.dataSource = self
        collectionCharacters.translatesAutoresizingMaskIntoConstraints = false
        return collectionCharacters
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        setUp()
    }
    
}

extension CharactersTableViewCell: ViewCode {
    func buildHierarchy() {
        addSubview(collectionCharacters)
    }
    
    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([ //pra simplificar adicona full por enquanto
            collectionCharacters.topAnchor.constraint(equalTo: topAnchor),
            collectionCharacters.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionCharacters.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionCharacters.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func aditionalConfigurations() {
        self.backgroundColor = .white
    }
}

extension CharactersTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CharactersCollectionViewCell
        cell.configureCell(character: characters[indexPath.row])
        cell.backgroundColor = colorCell!
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension CharactersTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionCharacters.bounds
        return CGSize(width: size.width/1.8, height: size.height/1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) // adicionar espaçamento interno a célula
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
