//
//  IntentHandler.swift
//  SiriSampleIntentsExtension
//
//  Created by Payal Gupta on 2/11/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import Intents
import CallMessage

class IntentHandler: INExtension
{
    override func handler(for intent: INIntent) -> Any
    {
        return self
    }
}

extension IntentHandler : INSendMessageIntentHandling
{
    func resolveRecipients(forSendMessage intent: INSendMessageIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void)
    {
        if let contacts = intent.recipients, !contacts.isEmpty
        {
            var results = [INPersonResolutionResult]()
            if contacts.count == 1
            {
                let contact = contacts.first!
                if contactNames.contains(contact.displayName)
                {
                    results.append(INPersonResolutionResult.success(with: contact))
                }
                else
                {
                    results.append(INPersonResolutionResult.unsupported())
                }
            }
            else if contacts.count > 1
            {
                results.append(INPersonResolutionResult.disambiguation(with: contacts))
            }
            else
            {
                results.append(INPersonResolutionResult.unsupported())
            }
            completion(results)
        }
        else
        {
            completion([INPersonResolutionResult.needsValue()])
        }
    }
    
    func resolveContent(forSendMessage intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void)
    {
        if let text = intent.content, !text.isEmpty
        {
            completion(INStringResolutionResult.success(with: text))
        }
        else
        {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func confirm(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void)
    {
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response = INSendMessageIntentResponse(code: .ready, userActivity: userActivity)
        completion(response)
    }
    
    func handle(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void)
    {
        let number = contactNumbers[contactNames.index(of: (intent.recipients?.first?.displayName)!)!]
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response : INSendMessageIntentResponse
        if sendMessageToNumber(number)
        {
            response = INSendMessageIntentResponse(code: .success, userActivity: userActivity)
        }
        else
        {
            response = INSendMessageIntentResponse(code: .failure, userActivity: userActivity)
        }
        completion(response)
    }
}

extension IntentHandler : INStartAudioCallIntentHandling
{
    func resolveContacts(forStartAudioCall intent: INStartAudioCallIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void)
    {
        if let contacts = intent.contacts, !contacts.isEmpty
        {
            var results = [INPersonResolutionResult]()
            if contacts.count == 1
            {
                let contact = contacts.first!
                if contactNames.contains(contact.displayName)
                {
                    results.append(INPersonResolutionResult.success(with: contact))
                }
                else
                {
                    results.append(INPersonResolutionResult.unsupported())
                }
            }
            else if contacts.count > 1
            {
                results.append(INPersonResolutionResult.disambiguation(with: contacts))
            }
            else
            {
                results.append(INPersonResolutionResult.unsupported())
            }
            completion(results)
        }
        else
        {
            completion([INPersonResolutionResult.needsValue()])
        }
    }
    
    func confirm(startAudioCall intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void)
    {
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INStartAudioCallIntent.self))
        let response = INStartAudioCallIntentResponse(code: .ready, userActivity: userActivity)
        completion(response)
    }
    
    func handle(startAudioCall intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void)
    {
        let number = contactNumbers[contactNames.index(of: (intent.contacts?.first?.displayName)!)!]
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response : INStartAudioCallIntentResponse
        if makeCallToNumber(number)
        {
            response = INStartAudioCallIntentResponse(code: .ready, userActivity: userActivity)
        }
        else
        {
            response = INStartAudioCallIntentResponse(code: .failure, userActivity: userActivity)
        }
        completion(response)
    }
}

