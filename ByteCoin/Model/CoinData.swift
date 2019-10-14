//
//  CoinData.swift
//  ByteCoin
//
//  Created by Joe on 10/14/19.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let last: Double
    let averages: Averages
}

struct Averages: Codable {
    var day: Double
    var week: Double
    var month: Double
}


