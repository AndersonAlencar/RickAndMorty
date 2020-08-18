//
//  ParameterEncoding.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 18/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterURLEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public protocol ParameterHTTPBodyEncoder {
    static func encode<T: Codable>(urlRequest: inout URLRequest, with parameters: T) throws
}

public enum NetworkEncoderError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameters encoding failed"
    case missingURL = "URL is nil"
}
