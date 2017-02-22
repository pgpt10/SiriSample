//
//  AudioCallIntentHandler.swift
//  SiriSample
//
//  Created by Payal Gupta on 2/22/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import UIKit
import Intents
import CallMessage

class AudioCallIntentHandler: NSObject, INStartAudioCallIntentHandling
{
    //1. Resolve
    func resolveContacts(forStartAudioCall intent: INStartAudioCallIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void)
    {
        if let recipients = intent.contacts
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
    
    //2. Confirm
    func confirm(startAudioCall intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void)
    {
        let response = INStartAudioCallIntentResponse(code: .ready, userActivity: nil)
        completion(response)
    }
    
    //3. Handle
    func handle(startAudioCall intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void)
    {
        if intent.contacts != nil
        {
            let success = makeCall(toRecipients : intent.contacts!)
            completion(INStartAudioCallIntentResponse(code: success ? .ready : .failure, userActivity: nil))
        }
        else
        {
            completion(INStartAudioCallIntentResponse(code: .failure, userActivity: nil))
        }
    }
}
