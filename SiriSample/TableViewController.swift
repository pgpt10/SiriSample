//
//  TableViewController.swift
//  SiriSample
//
//  Created by Payal Gupta on 2/11/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import UIKit
import CallMessage

class TableViewController: UITableViewController
{
    //MARK: View Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDelegate Methods
extension TableViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return contactNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = contactNames[indexPath.row]
        cell?.detailTextLabel?.text = contactNumbers[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if let numberString = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text
        {
            _ = makeCallToNumber(numberString)
        }
    }
}
