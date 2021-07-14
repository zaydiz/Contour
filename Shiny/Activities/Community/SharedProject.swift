//
//  SharedProject.swift
//  Shiny
//
//  Created by Anton Novoselov on 14.07.2021.
//

import Foundation

struct SharedProject: Identifiable {
    let id: String
    let title: String
    let detail: String
    let owner: String
    let closed: Bool

    static let example = SharedProject(id: "1",
                                       title: "Example",
                                       detail: "Detail",
                                       owner: "AntonNovoselov",
                                       closed: false)
}
