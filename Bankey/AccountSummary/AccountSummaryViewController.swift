//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Emerson Sampaio on 04/04/23.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    struct Profile {
        let firstName: String
        let lastName: String
    }

    var profile: Profile?
    var accounts: [AccountSummaryCell.ViewModel] = []
    
    var headerView = AccountSummaryHeaderView(frame: .zero)
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView(){
//        let header = AccountSummaryHeaderView(frame: .zero) OLD
        
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        guard !accounts.isEmpty else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AccountSummaryViewController {
    
    private func fetchData(){
        fetchAccounts()
        fetchProfile()
    }
    
    private func fetchAccounts(){
        let savings = AccountSummaryCell.ViewModel(
            accoountType: .Banking,
            accountName: "Basic Savings",
            balanceDollar: 929466,
            balanceCent: 63)
        
        let chequing = AccountSummaryCell.ViewModel(
            accoountType: .Banking,
            accountName: "No-Fee All-In Chequing",
            balanceDollar: 17562,
            balanceCent: 63)
        
        let visa = AccountSummaryCell.ViewModel(
            accoountType: .CreditCard,
            accountName: "Visa Avion Card",
            balanceDollar: 412,
            balanceCent: 63)
        
        let mastercard = AccountSummaryCell.ViewModel(
            accoountType: .CreditCard,
            accountName: "Student Mastercard",
            balanceDollar: 50,
            balanceCent: 63)
        
        let investment1 = AccountSummaryCell.ViewModel(
            accoountType: .Investment,
            accountName: "Tax-Free Saver",
            balanceDollar: 2000,
            balanceCent: 63)
        
        let investment2 = AccountSummaryCell.ViewModel(
            accoountType: .Investment,
            accountName: "Growth Fund",
            balanceDollar: 15000,
            balanceCent: 63)
        
        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(mastercard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
    
    private func fetchProfile(){
        profile = Profile(firstName: "Kevin", lastName: "Smith")
    }
}
