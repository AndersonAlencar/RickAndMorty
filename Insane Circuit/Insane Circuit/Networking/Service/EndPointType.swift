//
//  EndPointType.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 18/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

protocol EndPointType {
    associatedtype GenericCodable: Codable
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask<GenericCodable> { get }
    var headers: HTTPHeaders? { get }
}
