//
//  SceneDelegate.swift
//  Shiny
//
//  Created by Anton Novoselov on 31.05.2021.
//

import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    @Environment(\.openURL) var openURL
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        guard let url = URL(string: shortcutItem.type) else {
            completionHandler(false)
            return
        }
        
        openURL(url, completion: completionHandler)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let shortcutItem = connectionOptions.shortcutItem {
            guard let url = URL(string: shortcutItem.type) else {
                return
            }

            openURL(url)
        }
    }
}
