//
//  IntentViewController.swift
//  SiriSampleIntentsUIExtension
//
//  Created by Payal Gupta on 2/12/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import IntentsUI
import CallMessage

class IntentViewController: UIViewController, INUIHostedViewSiriProviding
{
    //MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    //MARK: View Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //MARK: Internal Properties
    var desiredSize: CGSize
    {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
    var displaysMessage : Bool
    {
        return true
    }
}

extension IntentViewController : INUIHostedViewControlling
{
    func configure(with interaction: INInteraction!, context: INUIHostedViewContext, completion: ((CGSize) -> Void)!)
    {
        if let sendMessageIntent = interaction.intent as? INSendMessageIntent
        {
            if let name = sendMessageIntent.recipients?.first?.displayName
            {
                self.nameLabel.text = name
                if let index = contactNames.index(of: name)
                {
                    let number = contactNumbers[index]
                    self.nameLabel.text = "\(name) (\(number))"
                }
            }
            if let content = sendMessageIntent.content
            {
                self.messageLabel.text = content
            }
            if let completion = completion
            {
                completion(CGSize(width: 0, height: 130))
            }
        }
    }
}
