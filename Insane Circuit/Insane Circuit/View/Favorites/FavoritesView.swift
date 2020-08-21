//
//  FavoritesView.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 20/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class FavoritesView: UIView {
    
    var characters = [Character]() 
    var imagesCharacters = [Data]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionFavorites.reloadData()
                self.emptyCharacters.isHidden = true
            }
        }
    }

    lazy var collectionFavorites: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionFavorites = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionFavorites.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewFavoriteCell")
        collectionFavorites.backgroundColor = .backgroundBlueColor
        collectionFavorites.showsHorizontalScrollIndicator = false
        collectionFavorites.delegate = self
        collectionFavorites.dataSource = self
        collectionFavorites.isPagingEnabled = false
        collectionFavorites.contentInsetAdjustmentBehavior = .never
        collectionFavorites.collectionViewLayout = flowLayout
        collectionFavorites.translatesAutoresizingMaskIntoConstraints = false
        return collectionFavorites
    }()
    
    lazy var emptyCharacters: UILabel = {
        let emptyCharacters = UILabel()
        emptyCharacters.font = UIFont.systemFont(ofSize: 20, weight: .bold) // talvez bold
        emptyCharacters.text = "No favorite characters"
        emptyCharacters.textColor = .labelColor
        emptyCharacters.isHidden = false
        emptyCharacters.translatesAutoresizingMaskIntoConstraints = false
        return emptyCharacters
    }()
    
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

extension FavoritesView: ViewCode {
    func buildHierarchy() {
        addSubview(collectionFavorites)
        addSubview(emptyCharacters)
    }
    
    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            collectionFavorites.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionFavorites.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionFavorites.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionFavorites.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emptyCharacters.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyCharacters.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func aditionalConfigurations() {
        backgroundColor = .backgroundBlueColor
    }
}

extension FavoritesView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionFavorites.dequeueReusableCell(withReuseIdentifier: "CollectionViewFavoriteCell", for: indexPath) as! CharactersCollectionViewCell
        if imagesCharacters.count == 0 {
            cell.configureCell(character: characters[indexPath.row], image: nil)
        } else {
            cell.configureCell(character: characters[indexPath.row], image: imagesCharacters[indexPath.row])
        }
        //cell.backgroundColor = .backgroundAliveColor
        cell.layer.cornerRadius = 10
        return cell
    }
    
}

extension FavoritesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionFavorites.bounds
        return CGSize(width: size.width/2.1, height: size.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0) // adicionar espaçamento interno a célula
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
}
