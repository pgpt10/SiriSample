//
//  Model.swift
//  SiriSample
//
//  Created by Payal Gupta on 2/11/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import UIKit
import MessageUI

public let contactNames = ["Nikita", "Saurabh", "Sonia", "Rahul", "Sahil", "Nidhi", "Vinay", "Roshan", "Sarita", "Aarti", "Sahil"]
public let contactNumbers = ["9643306897", "111111111", "2222222222", "3333333333", "4444444444", "5555555555", "6666666666", "7777777777", "8888888888", "9999999999", "1010101010"]

public func makeCallToNumber(_ numberToCall : String?) -> Bool
{
    if var numberToCall = numberToCall
    {
        numberToCall = numberToCall.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: numberToCall.range(of: numberToCall))
        
        if numberToCall.hasPrefix("91") && numberToCall.characters.count > 10
        {
            numberToCall = "+\(numberToCall)"
        }
        
        let urlSchema = "tel:"
        if let numberToCallURL = URL(string: "\(urlSchema)\(numberToCall)")
        {
            if UIApplication.shared.canOpenURL(numberToCallURL)
            {
                UIApplication.shared.open(numberToCallURL, options: [:], completionHandler: nil)
                return true
            }
        }
    }
    return false
}

public func sendMessageToNumber(_ number : String?) -> Bool
{
    if var number = number
    {
        number = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: number.range(of: number))
        
        if number.hasPrefix("91") && number.characters.count > 10
        {
            number = "+\(number)"
        }
        
        let urlSchema = "sms:"
        if let numberURL = URL(string: "\(urlSchema)\(number)")
        {
            if UIApplication.shared.canOpenURL(numberURL)
            {
                UIApplication.shared.open(numberURL, options: [:], completionHandler: nil)
                return true
            }
        }
    }
    return false
}
