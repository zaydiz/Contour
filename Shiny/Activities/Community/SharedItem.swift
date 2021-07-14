//
//  SharedItem.swift
//  Shiny
//
//  Created by Anton Novoselov on 14.07.2021.
//

import Foundation

struct SharedItem: Identifiable {
    let id: String
    let title: String
    let detail: String
    let completed: Bool
}
