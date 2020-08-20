//
//  RequestNewPageDelegate.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 20/08/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

protocol RequestNewPageDelegate: class {
    func requestNewPageAPI(page: Int, status: String)
}
