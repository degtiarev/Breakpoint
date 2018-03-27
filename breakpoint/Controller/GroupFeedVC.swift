//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 27/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {
    
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: InsertTextField!
    @IBOutlet weak var sendButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
