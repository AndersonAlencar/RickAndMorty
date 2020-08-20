//
//  CharactersView.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 18/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import UIKit

class CharactersView: UIView {
    
    weak var delegatePage: RequestNewPageDelegate?
    weak var delegatePresentCharactersView: DiscoverViewController?
    
    var charactersAlive:[Character] = [Character]()
//    {
//        didSet {
//            DispatchQueue.main.async {
//                //self.discoverCharactersTable.reloadData()
//            }
//        }
//    }
    
    var charactersDead:[Character] = [Character]()
    var charactersAlien:[Character] = [Character]()
    var imagesAlive:[Data] = [Data]() {
        didSet {
            DispatchQueue.main.async {
                self.discoverCharactersTable.reloadData()
            }
        }
    }
    
    var imagesDead:[Data] = [Data]() {
        didSet {
            DispatchQueue.main.async {
                self.discoverCharactersTable.reloadData()
            }
        }
    }
    
    var imagesAlien:[Data] = [Data]() {
        didSet {
            DispatchQueue.main.async {
                self.discoverCharactersTable.reloadData()
            }
        }
    }

    lazy var discoverCharactersTable: UITableView = {
        let discoverCharactersTable = UITableView()
        discoverCharactersTable.separatorStyle = .none
        discoverCharactersTable.showsVerticalScrollIndicator = false
        discoverCharactersTable.bounces = false
        discoverCharactersTable.delegate = self
        discoverCharactersTable.dataSource = self
        discoverCharactersTable.register(CharactersTableViewCell.self, forCellReuseIdentifier: "TableViewCellCharacter")
        //discoverCharactersTable.tableHeaderView = self.searchController.searchBar
        //discoverCharactersTable.tableHeaderView = self.search
        discoverCharactersTable.translatesAutoresizingMaskIntoConstraints = false
        return discoverCharactersTable
    }()
    
//    lazy var search: UISearchBar = {
//        let search = UISearchBar()
//        search.searchBarStyle = .default//
//        search.placeholder = "Search charcter"
//        search.isTranslucent = false//
//        search.sizeToFit()//
//        search.delegate = self
//        return search
//    }()
    
//    lazy var searchController: UISearchController = {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.definesPresentationContext = true
//        searchController.searchBar.sizeToFit()
//        searchController.searchBar.tintColor = .backgroundBlueColor
//        searchController.searchBar.barTintColor = .backgroundBlueColor
//        searchController.searchBar.text = "Search charcter..."
//        return searchController
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Extension TableView
extension CharactersView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // 1 para todos
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "Alive"
            case 1:
                return "Dead"
            default:
                return "Alien"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellCharacter", for: indexPath) as! CharactersTableViewCell
        cell.delegatePage = self
        cell.delegatePresentCharacters = self.delegatePresentCharactersView
        switch indexPath.section { // isso vai sair daqui e ir pra um configure cell na collection
            case 0:
                cell.colorCell = .backgroundAliveColor
                cell.characters = charactersAlive
                cell.images = imagesAlive
            case 1:
                cell.colorCell = .backgroundDeadColor
                cell.characters = charactersDead
                cell.images = imagesDead
            default:
                cell.colorCell = .backgroundAlienColor
                cell.characters = charactersAlien
                cell.images = imagesAlien

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { // setar a header das sections
        let headerView = UIView()
        headerView.backgroundColor = .backgroundBlueColor
        let headerTitle = UILabel(frame: CGRect(x: 24, y: 0, width:
        tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerTitle.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        headerTitle.textColor = .titleDiscoverColor
        headerTitle.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerTitle.sizeToFit()
        headerView.addSubview(headerTitle)
        return headerView
    }
    
}

extension CharactersView: RequestNewPageDelegate {
    func requestNewPageAPI(page: Int, status: String) {
        delegatePage?.requestNewPageAPI(page: page, status: status)
    }
    
}

extension CharactersView: UISearchBarDelegate {
    
}

// MARK: Extension ViewCode
extension CharactersView: ViewCode {
    func buildHierarchy() {
        addSubview(discoverCharactersTable)
    }
    
    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            discoverCharactersTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            discoverCharactersTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            discoverCharactersTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            discoverCharactersTable.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func aditionalConfigurations() {
        backgroundColor = .backgroundBlueColor
    }
}

// MARK: Extension UISearchBar
extension CharactersView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        print(text)
    }
}
