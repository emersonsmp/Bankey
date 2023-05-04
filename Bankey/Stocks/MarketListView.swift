//
//  MarketListView.swift
//  chart
//
//  Created by Emerson Sampaio on 01/05/23.
//

import Foundation
import UIKit
import Charts

class MarketListView: UIView, UITableViewDelegate{
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 7.0),
        ChartDataEntry(x: 3.0, y: 5.0),
        ChartDataEntry(x: 4.0, y: 10.0),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 6.0, y: 5.0),
        ChartDataEntry(x: 7.0, y: 7.0),
        ChartDataEntry(x: 8.0, y: 8.0),
        ChartDataEntry(x: 9.0, y: 12.0),
        ChartDataEntry(x: 10.0, y: 13.0),
        ChartDataEntry(x: 11.0, y: 5.0),
        ChartDataEntry(x: 12.0, y: 7.0),
        ChartDataEntry(x: 13.0, y: 3.0),
        ChartDataEntry(x: 14.0, y: 15.0),
        ChartDataEntry(x: 15.0, y: 6.0),
        ChartDataEntry(x: 16.0, y: 17.0),
        ChartDataEntry(x: 17.0, y: 16.0),
        ChartDataEntry(x: 18.0, y: 22.0),
        ChartDataEntry(x: 19.0, y: 20.0),
        ChartDataEntry(x: 20.0, y: 27.0),
        ChartDataEntry(x: 21.0, y: 23.0),
        ChartDataEntry(x: 22.0, y: 30.0),
        ChartDataEntry(x: 23.0, y: 50.0),
        ChartDataEntry(x: 24.0, y: 47.0),
        ChartDataEntry(x: 25.0, y: 55.0),
        ChartDataEntry(x: 26.0, y: 60.0),
        ChartDataEntry(x: 27.0, y: 39.0),
        ChartDataEntry(x: 28.0, y: 55.0),
        ChartDataEntry(x: 29.0, y: 70.0),
        ChartDataEntry(x: 30.0, y: 75.0),
        ChartDataEntry(x: 31.0, y: 58.0),
        ChartDataEntry(x: 32.0, y: 68.0),
        ChartDataEntry(x: 33.0, y: 77.0),
        ChartDataEntry(x: 34.0, y: 80.0),
        ChartDataEntry(x: 35.0, y: 69.0),
        ChartDataEntry(x: 36.0, y: 80.0),
        ChartDataEntry(x: 37.0, y: 90.0),
        ChartDataEntry(x: 38.0, y: 119.0),
        ChartDataEntry(x: 39.0, y: 110.0),
        ChartDataEntry(x: 40.0, y: 122.0)]
    
    let stockList = [
        StockListModel(name: "ITSA3", company: "Itausa Holding", value: "12,40", variation: "+0,42"),
        StockListModel(name: "ITSA4", company: "Itausa Holding", value: "9,76", variation: "+0,32"),
        StockListModel(name: "ITUB3", company: "Itau Brasil", value: "21,40", variation: "+0,12"),
        StockListModel(name: "AMAR3", company: "Americanas LTDA", value: "12,40", variation: "+0,32"),
        StockListModel(name: "AGOL3", company: "Gol Linhas Aereas", value: "34,76", variation: "+10,32"),
        StockListModel(name: "APL34", company: "Apple Inc", value: "121,00", variation: "+2,57"),
        StockListModel(name: "ENER3", company: "Energisa Bra", value: "22,40", variation: "+0,32"),
        StockListModel(name: "BRAD4", company: "Bradesco", value: "19,40", variation: "+0,72"),
        StockListModel(name: "OIBR3", company: "Oi Brasil", value: "0,68", variation: "+0,02"),
        StockListModel(name: "OIBR4", company: "Oi Brasil", value: "0,52", variation: "+0,03")]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "MyHeader")
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.reuseID)
        tableView.rowHeight = StockTableViewCell.rowHeight
        tableView.backgroundColor = appColor
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MarketListView {
    func style() {
        addSubview(tableView)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MarketListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseID, for: indexPath) as! StockTableViewCell
        cell.stockCodeNameLabel.text = stockList[indexPath.row].name
        cell.stockCompanyNameLabel.text = stockList[indexPath.row].company
        cell.valueLabel.text = stockList[indexPath.row].value
        cell.variationLabel.text = stockList[indexPath.row].variation
        cell.setData(yValues: yValues, title: "Stocks")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyHeader") as? MyTableHeaderView else {
            return nil
        }
        headerView.titleLabel.text = "Stocks"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}
