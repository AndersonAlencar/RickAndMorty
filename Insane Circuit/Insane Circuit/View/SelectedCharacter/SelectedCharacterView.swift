//
//  SelectedCharacterView.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 20/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class SelectedCharacterView: UIView {

    lazy var checkFavoritePressed: Bool = {
       return false
    }()
    var persistenceUserDefaults = Persistence()
    
    var character: Character?
    var image: Data?
    
    lazy var imageCharacter: UIImageView = {
        let imageCharacter = UIImageView()
        imageCharacter.clipsToBounds = true
        imageCharacter.layer.cornerRadius = 10
        imageCharacter.image = UIImage(named: "rick")
        imageCharacter.translatesAutoresizingMaskIntoConstraints = false
        return imageCharacter
    }()
    
    lazy var nameCharacter: UILabel = {
        let nameCharacter = UILabel()
        nameCharacter.font = UIFont.systemFont(ofSize: 25, weight: .semibold) // talvez bold
        nameCharacter.adjustsFontSizeToFitWidth = true
        nameCharacter.textColor = .labelColor
        nameCharacter.textColor = .white
        nameCharacter.translatesAutoresizingMaskIntoConstraints = false
        return nameCharacter
    }()
    
    lazy var gender: UILabel = {
        let gender = UILabel()
        gender.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        gender.adjustsFontSizeToFitWidth = true
        gender.textColor = .labelColor
        gender.text = "Human - Male"
        gender.textColor = .white
        gender.translatesAutoresizingMaskIntoConstraints = false
        return gender
    }()
    
    lazy var status: UILabel = {
        let status = UILabel()
        status.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        status.adjustsFontSizeToFitWidth = true
        status.textAlignment = .right
        status.textColor = .labelColor
        status.text = "Alive"
        status.textColor = .white
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var lastSeenLabel: UILabel = {
        let lastSeen = UILabel()
        lastSeen.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        lastSeen.adjustsFontSizeToFitWidth = true
        lastSeen.text = "Last Seen"
        lastSeen.textColor = .white
        lastSeen.translatesAutoresizingMaskIntoConstraints = false
        return lastSeen
    }()
    
    lazy var location: UILabel = {
        let location = UILabel()
        location.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        location.adjustsFontSizeToFitWidth = true
        location.textColor = .labelSecondaryColor
        location.text = "Last Seen"
        location.textColor = .white
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()
    
    lazy var favorite: UIButton = {
        let favorite = UIButton()
        favorite.setImage(UIImage(named: "Favoritar"), for: .normal)
        favorite.addTarget(self, action: #selector(clickFavorite(sender:)), for: .touchUpInside)
        favorite.translatesAutoresizingMaskIntoConstraints = false
        return favorite
    }()
    
    lazy var episodesLabel: UILabel = {
        let episodesLabel = UILabel()
        episodesLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        episodesLabel.adjustsFontSizeToFitWidth = true
        episodesLabel.textColor = .labelSecondaryColor
        episodesLabel.text = "Episodes"
        episodesLabel.textColor = .white
        episodesLabel.translatesAutoresizingMaskIntoConstraints = false
        return episodesLabel
    }()
    
    lazy var collectionEpisodes: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionEpisodes = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionEpisodes.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewEpisodeCell")
        collectionEpisodes.backgroundColor = .backgroundBlueColor
        collectionEpisodes.showsHorizontalScrollIndicator = false
        collectionEpisodes.isPagingEnabled = false
        collectionEpisodes.contentInsetAdjustmentBehavior = .never
        collectionEpisodes.collectionViewLayout = flowLayout
        collectionEpisodes.delegate = self
        collectionEpisodes.dataSource = self
        collectionEpisodes.translatesAutoresizingMaskIntoConstraints = false
        return collectionEpisodes
    }()
    
    init(frame: CGRect, character: Character, imageCharacter: Data) {
        super.init(frame: frame)
        self.character = character
        self.image = imageCharacter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setUp()
        configureView(imageData: image!)

    }
    
    func configureView(imageData: Data) {
        imageCharacter.image = UIImage(data: imageData)
        nameCharacter.text = character?.name
        nameCharacter.textColor = .labelColor
        gender.text =  "\(character!.species) - \(character!.gender)"
        gender.textColor = .labelColor
        status.text = character?.status
        status.textColor = .labelColor
        location.text = character?.location.name
        location.textColor = .labelColor
        
        lastSeenLabel.textColor = .labelSecondaryColor
        episodesLabel.textColor = .labelSecondaryColor
        
        //verificar a persistencia do objeto pra mudar o botão
        if persistenceUserDefaults.existObjetc(object: character!.id) {
            checkFavoritePressed = true
            favorite.setImage(UIImage(named: "Favoritado"), for: .normal)
        }
    }
    
    @objc func clickFavorite(sender: UIButton!) {
        checkFavoritePressed = !checkFavoritePressed
        if checkFavoritePressed {
            favorite.setImage(UIImage(named: "Favoritado"), for: .normal)
            persistenceUserDefaults.add(object: character!.id)
        } else {
            favorite.setImage(UIImage(named: "Favoritar"), for: .normal)
            persistenceUserDefaults.remove(object: character!.id)
        }
    }
}

extension SelectedCharacterView: ViewCode {
    func buildHierarchy() {
        addSubview(imageCharacter)
        addSubview(nameCharacter)
        addSubview(gender)
        addSubview(status)
        addSubview(lastSeenLabel)
        addSubview(location)
        addSubview(favorite)
        addSubview(episodesLabel)
        addSubview(collectionEpisodes)
    }
    
    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            imageCharacter.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            imageCharacter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            imageCharacter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38),
            imageCharacter.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            nameCharacter.topAnchor.constraint(equalTo: imageCharacter.bottomAnchor, constant: 20),
            nameCharacter.centerXAnchor.constraint(equalTo: imageCharacter.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            gender.topAnchor.constraint(equalTo: nameCharacter.bottomAnchor, constant: 30),
            gender.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            gender.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
        NSLayoutConstraint.activate([
            status.leadingAnchor.constraint(equalTo: gender.trailingAnchor),
            status.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38),
            status.centerYAnchor.constraint(equalTo: gender.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            lastSeenLabel.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 32),
            lastSeenLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            lastSeenLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)

        ])
        NSLayoutConstraint.activate([
            location.topAnchor.constraint(equalTo: lastSeenLabel.bottomAnchor, constant: 17),
            location.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 58),
            location.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
        ])
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: lastSeenLabel.bottomAnchor, constant: 17),
            favorite.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38)
        ])
        NSLayoutConstraint.activate([
            episodesLabel.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 32),
            episodesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            episodesLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)

        ])
        NSLayoutConstraint.activate([
            collectionEpisodes.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: 15),
            collectionEpisodes.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionEpisodes.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionEpisodes.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)

        ])
    }
    
    func aditionalConfigurations() {
        backgroundColor = .backgroundBlueColor
    }
}

extension SelectedCharacterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return character!.episode.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewEpisodeCell", for: indexPath) as! EpisodesCollectionViewCell
        let episode = character!.episode[indexPath.row].filter {"0123456789".contains($0)}
        cell.configureCell(episode: Int(episode)!)
        if indexPath.row % 2 == 0 {
            cell.imageEpisode.image = UIImage(named: "wallpp1")
        } else {
            cell.imageEpisode.image = UIImage(named: "wallpp2")

        }
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension SelectedCharacterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionEpisodes.bounds
        return CGSize(width: size.width/1.8, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 38, bottom: 0, right: 0) // adicionar espaçamento interno a célula
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
