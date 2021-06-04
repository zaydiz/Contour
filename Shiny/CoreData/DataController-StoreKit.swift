//
//  DataController-StoreKit.swift
//  Shiny
//
//  Created by Anton Novoselov on 04.06.2021.
//

import StoreKit
extension DataController {
    func appLaunched() {
        return
        guard count(for: Project.fetchRequest()) >= 5 else { return }

        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }

        if let windowScene = scene as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}
