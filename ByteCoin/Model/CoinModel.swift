//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Joe on 10/14/19.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let currentValue: Double
    let averageDayValue: Double
    
    init(value: Double, average: Double) {
        self.currentValue = value
        self.averageDayValue = average
    }
}
