//
//  SKProduct-LocalizedPrice.swift
//  Shiny
//
//  Created by Anton Novoselov on 30.05.2021.
//

import StoreKit

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}
