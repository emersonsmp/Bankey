//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Emerson Sampaio on 04/04/23.
//

import Foundation
import UIKit

class AccountSummaryCell: UITableViewCell {
    
    let typeLabel = UILabel()
    let underLineView = UIView()
    let nameLabel = UILabel()
    
    let balanceStakeView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 100
    
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
        typeLabel.text = "Account type"
        
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = appColor
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.text = "Account name"
        
        balanceStakeView.translatesAutoresizingMaskIntoConstraints = false
        balanceStakeView.axis = .vertical
        balanceStakeView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.text = "Some balance"
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        balanceAmountLabel.text = "$929,446.63"
        
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
            //TEACHER CODE
            //typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            //typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            //MY CODE
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
            
//            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            
//            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
            
            chevronImageView.topAnchor.constraint(equalTo: underLineView.bottomAnchor, constant: 8),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
}
