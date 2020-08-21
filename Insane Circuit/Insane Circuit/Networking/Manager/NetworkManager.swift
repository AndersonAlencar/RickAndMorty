//
//  NetworkManager.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 18/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

struct NetworkManager {
    private let router = Router<APIEndPoints>()
    
    enum NetworkResponse: String {
        case success
        case authenticationError = "You need to be authenticated first"
        case badRequest = "Bad Request"
        case outdated = "The url you requested is outdated"
        case falied = "Network Request Failed"
        case noData = "Response return with no Data to decode"
        case unableToDecode = "We could not decodethe response"
    }
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    func handleNetworkResponse(_ reponse: HTTPURLResponse) -> Result<String> {
        switch reponse.statusCode {
            case 200...299:
                return .success
            case 401...500:
                return .failure(NetworkResponse.authenticationError.rawValue)
            case 501...599:
                return .failure(NetworkResponse.badRequest.rawValue)
            case 600:
                return .failure(NetworkResponse.outdated.rawValue)
            default:
                return .failure(NetworkResponse.falied.rawValue)
        }
    }
    
    func getCharacter(id: Int,completion: @escaping (_ places: Character?, _ error: String?) -> Void) {
        router.request(.character(id: id)) { (data, _, error) in
            if error != nil {
                completion(nil,"Please check your network connection")
            }
            
            if let data = data {
                do {
                    let character = try JSONDecoder().decode(Character.self, from: data)
                    completion(character,nil)
                } catch {
                    completion(nil,NetworkResponse.unableToDecode.rawValue)
                }
                
            }
        }
    }
    
    func getCharactersAlive(page: Int,completion: @escaping (_ places: CharacterResults?, _ error: String?) -> Void) {
        router.request(.charactersAlive(page: page)) { (data, _, error) in
            if error != nil {
                completion(nil,"Please check your network connection")
            }
            
            if let data = data {
                do {
                    let characters = try JSONDecoder().decode(CharacterResults.self, from: data)
                    completion(characters,nil)
                } catch {
                    completion(nil,NetworkResponse.unableToDecode.rawValue)
                }
                
            }
        }
    }
    
    func getCharactersDead(page: Int,completion: @escaping (_ places: CharacterResults?, _ error: String?) -> Void) {
        router.request(.charactersDead(page: page)) { (data, _, error) in
            if error != nil {
                completion(nil,"Please check your network connection")
            }
            
            if let data = data {
                do {
                    let characters = try JSONDecoder().decode(CharacterResults.self, from: data)
                    completion(characters,nil)
                } catch {
                    completion(nil,NetworkResponse.unableToDecode.rawValue)
                }
                
            }
        }
    }
    
    func getCharactersAlien(page: Int,completion: @escaping (_ places: CharacterResults?, _ error: String?) -> Void) {
        router.request(.charactersAlien(page: page)) { (data, _, error) in
            if error != nil {
                completion(nil,"Please check your network connection")
            }
            
            if let data = data {
                do {
                    let characters = try JSONDecoder().decode(CharacterResults.self, from: data)
                    completion(characters,nil)
                } catch {
                    completion(nil,NetworkResponse.unableToDecode.rawValue)
                }
                
            }
        }
    }
    
    func getCharacterImage(id: Int,completion: @escaping (_ places: Data?, _ error: String?) -> Void) {
        router.request(.characterImage(id: id)) { (data, _, error) in
            if error != nil {
                completion(nil,"Please check your network connection")
            }
            
            if let data = data {
                completion(data,nil)
            }
        }
    }
    
    func getFavoritesCharacters(ids: [Int],completion: @escaping (_ places: [Character]?, _ error: String?) -> Void) {
        router.request(.charactersFavorites(ids: ids)) { (data, _, error) in
            if error != nil {
                completion(nil,"Please check your network connection")
            }
            
            if let data = data {
                do {
                    let characters = try JSONDecoder().decode([Character].self, from: data)
                    completion(characters,nil)
                } catch {
                    completion(nil,NetworkResponse.unableToDecode.rawValue)
                }
                
            }
        }
    }
}
