//
//  IntentHandler.swift
//  SiriSampleIntentsExtension
//
//  Created by Payal Gupta on 2/11/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import Intents

class IntentHandler: INExtension
{
    override func handler(for intent: INIntent) -> Any?
    {
        if intent is INSendMessageIntent
        {
            return SendMessageIntentHandler()
        }
        else if intent is INStartAudioCallIntent
        {
            return AudioCallIntentHandler()
        }
        return nil
    }
}

