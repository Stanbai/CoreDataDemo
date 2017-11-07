//
//  Model.swift
//  Second
//
//  Created by Stan on 2017-11-05.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import Foundation

struct User: Codable {
    var avatarImg: Data
    var isRelative: Bool
    var name: String
    var updateTime: Date
    var viewTimes: Int64
    var mobile: String     
}

