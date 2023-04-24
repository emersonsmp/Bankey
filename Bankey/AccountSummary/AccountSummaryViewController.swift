//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Emerson Sampaio on 04/04/23.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    //request models
    var profile: Profile?
    var accounts: [Account] = []
    
    //view models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(
        welcomeMessage: "Welcome",
        name: "",
        date: Date())
    var accountsCellViewModels: [AccountSummaryCell.ViewModel] = []
    
    //components
    var headerView = AccountSummaryHeaderView(frame: .zero)
    var tableView = UITableView()
    var refreshControl = UIRefreshControl()
    
    var isLoaded = false
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController {
    private func setup() {
        setupNavigationBar()
        setupTableView()
        setupTableHeaderView()
        setupRefreshControl()
        setupSkeletons()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
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
        
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    func setupRefreshControl(){
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupSkeletons(){
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        
        configureTableCell(with: accounts)
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountsCellViewModels.isEmpty else { return UITableViewCell() }
        let account = accountsCellViewModels[indexPath.row]
        
        if isLoaded{
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            cell.configure(with: account)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsCellViewModels.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AccountSummaryViewController {
    
    private func fetchData(){
        fetchDataAndLoadViews()
    }
}

extension AccountSummaryViewController {
    private func fetchDataAndLoadViews() {
        let group = DispatchGroup()
        
        //Testing - random number selection
        let userId = String(Int.random(in: 1..<4))
        
        group.enter()
        fetchProfile(forUserId: userId) { result in
            switch result {
                case .success(let profile):
                    self.profile = profile
                    self.configureTableHeaderView(with: profile)
                case .failure(let error):
                    self.displayError(error: error)
            }
            group.leave()
        }
        
        group.enter()
        fetchAccounts(forUserId: "1") { result in
            switch result {
                case .success(let accounts):
                    self.accounts = accounts
                    self.configureTableCell(with: accounts)
                    
                case .failure(let error):
                    self.displayError(error: error)
            }
            group.leave()
        }
        
        group.notify(queue: .main){
            self.isLoaded = true
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCell(with accounts: [Account]) {
        accountsCellViewModels = accounts.map{
            AccountSummaryCell.ViewModel(accoountType: $0.type,
                                         accountName: $0.name,
                                         balance: $0.amount)
        }
    }
    
    func displayError(error: NetworkError){
        let title: String
        let message: String
        
        switch error {
            case .serverError:
                title = "Server Error"
                message = "Ensure you are connected to the internet. please try again."
                
            case .decodingError:
                title = "Decoding Error"
                message = "We could not process your request. please try again"
        }
        
        self.showErrorAlert(title: title, message: message)
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

//MARK:
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton){
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshContent(){
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset(){
        profile = nil
        accounts = []
        isLoaded = false
    }
}
