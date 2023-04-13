//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Emerson Sampaio on 04/04/23.
//

import Foundation
import UIKit

class AccountSummaryCell: UITableViewCell {
    
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
    
    struct ViewModel {
        let accoountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var balanceAsAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    let viewModel: ViewModel? = nil
    
    let typeLabel = UILabel()
    let underLineView = UIView()
    let nameLabel = UILabel()
    
    let balanceStakeView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryCell {
    private func setup(){
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = appColor
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontForContentSizeCategory = true
        
        balanceStakeView.translatesAutoresizingMaskIntoConstraints = false
        balanceStakeView.axis = .vertical
        balanceStakeView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.adjustsFontSizeToFitWidth = true
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(underLineView)
        contentView.addSubview(nameLabel)
        
        balanceStakeView.addArrangedSubview(balanceLabel)
        balanceStakeView.addArrangedSubview(balanceAmountLabel)
        
        contentView.addSubview(balanceStakeView)
        contentView.addSubview(chevronImageView)
        
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            
            typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            underLineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            underLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            underLineView.widthAnchor.constraint(equalToConstant: 60),
            underLineView.heightAnchor.constraint(equalToConstant: 4),
            
            nameLabel.topAnchor.constraint(equalTo: underLineView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            balanceStakeView.topAnchor.constraint(equalTo: underLineView.bottomAnchor, constant: 0),
            balanceStakeView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 32),
            balanceStakeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            chevronImageView.topAnchor.constraint(equalTo: underLineView.bottomAnchor, constant: 8),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]

        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)

        rootString.append(dollarString)
        rootString.append(centString)

        return rootString
    }
}

extension AccountSummaryCell {
    func configure(with vm: ViewModel){
        typeLabel.text = vm.accoountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accoountType {
            case .Banking:
                underLineView.backgroundColor = appColor
                balanceLabel.text = "Current"
            case .CreditCard:
                underLineView.backgroundColor = .systemOrange
                balanceLabel.text = "Balance"
            case .Investment:
                underLineView.backgroundColor = .systemPurple
                balanceLabel.text = "Value"
        }
    }
}
