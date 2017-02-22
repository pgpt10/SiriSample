//
//  Model.swift
//  SiriSample
//
//  Created by Payal Gupta on 2/11/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import UIKit
import Intents

public let contacts = [
    ["name": "Nikita", "number": "9643306897"],
    ["name": "Nupur Gupta", "number": "1111111111"],
    ["name": "Nupur Aluria", "number": "222222222"]]

public func matchingContactsWithName(_ name : String) -> [INPerson]
{
    var matchedContacts = [INPerson]()
    for dict in contacts
    {
        if (dict["name"]?.contains(name))!
        {
            matchedContacts.append(dict.inPerson)
        }
    }
    return matchedContacts
}

public func sendMessage(_ content : String?, toRecipients : [INPerson]) -> Bool
{
    //TODO: Send Message Logic
    return true
}

public func makeCall(toRecipients : [INPerson]) -> Bool
{
    //TODO: Call Logic
    return true
}

extension Dictionary
{
    var inPerson : INPerson{
        return INPerson(personHandle: INPersonHandle.init(value: self["number" as! Key] as! String, type: INPersonHandleType.phoneNumber), nameComponents: nil, displayName: self["name" as! Key] as? String, image: nil, contactIdentifier: nil, customIdentifier: nil)
    }
}

//public func updateSiriVocabulary()
//{
//    DispatchQueue.init(label: "SiriVocabulary").async {
//        var names = [String]()
//        for dict in contacts
//        {
//            names.append(dict["name"]!)
//        }
//        let orderedNames = NSOrderedSet.init(array: names)
//        INVocabulary.shared().setVocabularyStrings(orderedNames, of: .contactName)
//    }
//}
