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
    
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendButtonView.bindToKeyBoard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tittleLabel.text = group?.groupTittle
        DataService.instance.getEmailForGroup(group: group!) { (emailsArray) in
            self.membersLabel.text = emailsArray.joined(separator: ", ")
        }
    }
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
