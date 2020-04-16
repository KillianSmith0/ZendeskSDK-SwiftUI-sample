//
//  ZendeskMessaging.swift
//  UnifiedSDKSample
//
//  Created by Zendesk on 13/04/2020.
//  Copyright © 2020 Zendesk. All rights reserved.
//

import SwiftUI

import MessagingSDK // Messaging VC
import CommonUISDK // Styling

// Engines
import AnswerBotSDK
import ChatSDK

// API Config, VisitorInfo, Chat instance.
import ChatProvidersSDK

struct MessagingView: View {
    let themeColor: UIColor

    var body: some View {
        MessagingController(themeColor: themeColor)
    }
}

struct MessagingController: UIViewControllerRepresentable {
    var controllers: [UIViewController] = []
    var themeColor: UIColor

    var messagingConfiguration: MessagingConfiguration {
        let messagingConfiguration = MessagingConfiguration()
        messagingConfiguration.name = "Chat Bot"
        return messagingConfiguration
    }

    var chatConfiguration: ChatConfiguration {
        let chatConfiguration = ChatConfiguration()
        chatConfiguration.chatMenuActions = [.endChat]
        chatConfiguration.isAgentAvailabilityEnabled = false
        return chatConfiguration
    }

    var chatAPIConfig: ChatAPIConfiguration {
        let chatAPIConfig = ChatAPIConfiguration()
        chatAPIConfig.department = "Sales"
        chatAPIConfig.tags = ["iOS", "chat_v2"]
        chatAPIConfig.visitorInfo = VisitorInfo(name: "iOS User_\(UUID().uuidString)", email: "test@email.com", phoneNumber: "")
        return chatAPIConfig
    }

    func updateMessagingStyling() {
        CommonTheme.currentTheme.primaryColor = themeColor
    }

    func buildMessagingViewController() throws -> UIViewController {
        let chatEngine = try ChatEngine.engine()
        let answerBotEngine = try AnswerBotEngine.engine()

        return try Messaging.instance.buildUI(engines: [answerBotEngine, chatEngine],
                                              configs: [messagingConfiguration, chatConfiguration])
    }

    func updateUIViewController(_ uiViewController: UIViewController,
                                 context: UIViewControllerRepresentableContext<MessagingController>) {
     }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MessagingController>) -> UIViewController {
        do {
            Chat.instance?.configuration = chatAPIConfig
            self.updateMessagingStyling()
            return try buildMessagingViewController()
        } catch  {
            fatalError("Failed to create viewController")
        }
    }
}
