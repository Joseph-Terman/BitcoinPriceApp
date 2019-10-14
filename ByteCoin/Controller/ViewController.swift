//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var valueType: UISegmentedControl!
    
    var coinManager = CoinManager()
    var index = 0
    var rowSelected = false
    var currency = "USD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
        
    }
    
    
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdatePriceDetails(_ CoinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            
            if self.index == 0 {
                self.bitcoinLabel.text = String(format: "%0.2f", coin.currentValue)
            } else {
                self.bitcoinLabel.text = String(format: "%0.2f", coin.averageDayValue)
            }
        }
    }
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - UIPickerViewDataSource and Delegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.rowSelected = true
        let currency = coinManager.currencyArray[row]
        self.currency = currency
        currencyLabel.text = currency
        coinManager.getCoinPrice(for: currency)
    }
    
    @IBAction func valueTypeSelected(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        if rowSelected == false {
            return
        } else {
            coinManager.getCoinPrice(for: currency)
        }
    }
}

