//
//  AppDelegate.swift
//  UnifiedSDKSample
//
//  Created by Zendesk on 13/04/2020.
//  Copyright © 2020 Zendesk. All rights reserved.
//

import UIKit

import ChatProvidersSDK

import AnswerBotProvidersSDK
import SupportProvidersSDK
import ZendeskCoreSDK

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAnswerBot()
        setupChat()
        return true
    }

    private func setupAnswerBot() {
        Zendesk.initialize(appId: <#T##String#>, clientId: <#T##String#>, zendeskUrl: <#T##String#>)
        Support.initialize(withZendesk: Zendesk.instance!)
        AnswerBot.initialize(withZendesk: Zendesk.instance!, support: Support.instance!)
    }

    private func setupChat(){
        Chat.initialize(accountKey: <#String#>)
        Logger.defaultLevel = .verbose // Chat logging
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}

