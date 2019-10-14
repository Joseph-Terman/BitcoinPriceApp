//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdatePriceDetails(_ CoinManager: CoinManager, coin: CoinModel)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    
    mutating func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)\(currency)"
        performRequest(with: urlString)
    }
    
    func performRequest(with url: String) {
        //create url
        if let url = URL(string: url) {
            
            //create url session
            let session = URLSession(configuration: .default)
            
            //give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let confirmedData = data {
                    //let dataToString = String(data: confirmedData, encoding: String.Encoding.utf8)!
                    if let coin = self.parseJSON(confirmedData) {
                        self.delegate?.didUpdatePriceDetails(self, coin: coin)
                    }
                }
            }
            
            //start or resume task
            task.resume()
        }

    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(CoinData.self, from: coinData)
            let value = decodeData.last
            let average = decodeData.averages.day
            let coinModel = CoinModel(value: value, average: average)
            return coinModel
        } catch {
            self.delegate?.didFailWithError(error)
            return nil
        }
        
    }
    
}
