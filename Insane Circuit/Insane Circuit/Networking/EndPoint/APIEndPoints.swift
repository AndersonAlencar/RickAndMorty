//
//  APIEndPoints.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 18/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

enum APIEndPoints {
    case character(id: Int)
    case charactersAlive(page: Int)
    case charactersDead(page: Int)
    case charactersAlien(page: Int)
    case characterImage(id: Int)
    case charactersFavorites(ids: [Int])
}

extension APIEndPoints: EndPointType {
        
    var baseURL:URL {
        return URL(string: "https://rickandmortyapi.com/api/")!
    }
    
    var path: String {
        switch self {
            case .character(let id):
                return "character/\(id)"
            case .characterImage(let id):
                return "character/avatar/\(id).jpeg"
            case .charactersFavorites(let ids):
                var path = "character/"
                for (index,id) in ids.enumerated() {
                    path += index == ids.count-1 ? "\(id)":"\(id),"
                }
                return path
            default:
                return "character/"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask<Int> {
        switch self {
            case .charactersAlive(let page):
                return .requestParameters(urlParameters: ["status":"alive","page":"\(page)"])
            case .charactersDead(let page):
                return .requestParameters(urlParameters: ["status":"dead","page":"\(page)"])
            case .charactersAlien(let page):
                return .requestParameters(urlParameters: ["species":"alien","page":"\(page)"])
            default:
                return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
