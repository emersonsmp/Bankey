//
//  StocksViewController.swift
//  Bankey
//
//  Created by Emerson Sampaio on 04/05/23.
//

import Foundation
import UIKit

class StocksViewController: UIViewController {
    var StockList: MarketListView?
    
    override func loadView() {
        self.StockList = MarketListView()
        
        self.view = self.StockList
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
