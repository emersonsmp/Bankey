//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Emerson Sampaio on 05/04/23.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
