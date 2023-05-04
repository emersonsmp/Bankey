//
//  MyTableHeaderView.swift
//  Bankey
//
//  Created by Emerson Sampaio on 04/05/23.
//

import Foundation
import UIKit

class MyTableHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "STOCKS"
        title.font = .boldSystemFont(ofSize: 32)
        title.textColor = .white
        return title
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = appColor

        self.contentView.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
