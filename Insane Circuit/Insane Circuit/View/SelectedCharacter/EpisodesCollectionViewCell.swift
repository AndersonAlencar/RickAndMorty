//
//  EpisodesCollectionViewCell.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 20/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class EpisodesCollectionViewCell: UICollectionViewCell {
    
    lazy var imageEpisode: UIImageView = {
        let imageEpisode = UIImageView()
        imageEpisode.clipsToBounds = true
        imageEpisode.translatesAutoresizingMaskIntoConstraints = false
        return imageEpisode
    }()
    
    lazy var episodeNumber: UILabel = {
        let episodeNumber = UILabel()
        episodeNumber.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        episodeNumber.adjustsFontSizeToFitWidth = true
        episodeNumber.textColor = .white
        episodeNumber.translatesAutoresizingMaskIntoConstraints = false
        return episodeNumber
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(episode: Int) {
        imageEpisode.image = UIImage(named: "wallpp\(Int.random(in: 1...3))")
        episodeNumber.textColor = .labelEpisodeColor
        if episode < 10 {
            episodeNumber.text = "0\(episode)"
        } else {
            episodeNumber.text = "\(episode)"
        }
    }
    
    override func layoutSubviews() {
        setUp()
    }
}

extension EpisodesCollectionViewCell: ViewCode {
    func buildHierarchy() {
        addSubview(imageEpisode)
        addSubview(episodeNumber)
    }
    
    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            imageEpisode.topAnchor.constraint(equalTo: topAnchor),
            imageEpisode.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageEpisode.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageEpisode.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            episodeNumber.centerXAnchor.constraint(equalTo: centerXAnchor),
            episodeNumber.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func aditionalConfigurations() {
        self.layer.masksToBounds = true
    }
}
