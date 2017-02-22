//
//  SendMessageIntentHandler.swift
//  SiriSample
//
//  Created by Payal Gupta on 2/22/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import UIKit
import Intents
import CallMessage

class SendMessageIntentHandler: NSObject, INSendMessageIntentHandling
{
    //1. Resolve
    func resolveRecipients(forSendMessage intent: INSendMessageIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void)
    {
        if let recipients = intent.recipients
        {
            var resolutionResults = [INPersonResolutionResult]()
            for recipient in recipients
            {
                let matchingContacts = matchingContactsWithName(recipient.displayName)
                switch matchingContacts.count
                {
                case 2...Int.max:
                    resolutionResults.append(.disambiguation(with: matchingContacts))
                case 1:
                    resolutionResults.append(.success(with: matchingContacts.first!))
                case 0:
                    resolutionResults.append(.unsupported())
                default:
                    break
                }
            }
            completion (resolutionResults)
        }
        else
        {
            completion([.needsValue()])
        }
    }
    
    func resolveContent(forSendMessage intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void)
    {
        if let text = intent.content, !text.isEmpty
        {
            completion(.success(with: text))
        }
        else
        {
            completion(.needsValue())
        }
    }
    
    //2. Confirm
    func confirm(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void)
    {
        let response = INSendMessageIntentResponse(code: .success, userActivity: nil)
        completion(response)
    }
    
    //3. Handle
    func handle(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void)
    {
        if intent.recipients != nil && intent.content != nil
        {
            let success = sendMessage(intent.content, toRecipients : intent.recipients!)
            completion(INSendMessageIntentResponse(code: success ? .success : .failure, userActivity: nil))
        }
        else
        {
            completion(INSendMessageIntentResponse(code: .failure, userActivity: nil))
        }
    }
}
