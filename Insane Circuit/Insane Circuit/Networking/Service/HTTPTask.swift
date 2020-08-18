//
//  HTTPTask.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 18/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask<T: Codable> {
    case request
    case requestParameters(urlParameters: Parameters?)
    case requestParametersAndHeaders(urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
    //case requestParameters(bodyParameters: T?, urlParameters: Parameters?)
   
}
