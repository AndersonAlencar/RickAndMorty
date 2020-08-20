//
//  CharactersTableViewCell.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 18/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    let manager = NetworkManager()
    weak var delegatePage: RequestNewPageDelegate?
    weak var delegatePresentCharacters: DiscoverViewController?
    private var pagesAPI = [1,1,1]
    private var totalPage = 15
    
    var characters: [Character] = [Character]()
    
    var images:[Data] = [Data]() {
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
        collectionCharacters.showsHorizontalScrollIndicator = false
        collectionCharacters.isPagingEnabled = false
        collectionCharacters.contentInsetAdjustmentBehavior = .never
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
        if images.count == 0 {
            cell.configureCell(character: characters[indexPath.row], image: nil)
        } else {
            cell.configureCell(character: characters[indexPath.row], image: images[indexPath.row])
        }
        if indexPath.row % totalPage == 0 && indexPath.row != 0 {
            print("chegou no 15")
            print(indexPath.row)
            switch characters[indexPath.row].status {
                case "Alive":
                    pagesAPI[0] += 1
                    delegatePage?.requestNewPageAPI(page: pagesAPI[0], status: "alive" )
                case "Dead":
                    pagesAPI[1] += 1
                    delegatePage?.requestNewPageAPI(page: pagesAPI[1], status: "dead")
                default:
                    pagesAPI[2] += 1
                    delegatePage?.requestNewPageAPI(page: pagesAPI[2], status: "alien")
            }
            totalPage += 15
        }
        cell.backgroundColor = colorCell!
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterSelectedController = SelectedCharacterViewController()
        characterSelectedController.character = characters[indexPath.row]
        characterSelectedController.characterImage = images[indexPath.row]
        let modalcharacters = UINavigationController(rootViewController: characterSelectedController)
        modalcharacters.modalPresentationStyle = .fullScreen
        delegatePresentCharacters?.present(modalcharacters, animated: true, completion: nil)
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
