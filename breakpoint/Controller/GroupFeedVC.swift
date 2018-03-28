//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 27/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
    
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: InsertTextField!
    @IBOutlet weak var sendButtonView: UIView!
    
    var group: Group?
    var messagesArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        sendButtonView.bindToKeyBoard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tittleLabel.text = group?.groupTittle
        DataService.instance.getEmailForGroup(group: group!) { (emailsArray) in
            self.membersLabel.text = emailsArray.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllFeedMessagesForGroup(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.messagesArray = returnedGroupMessages
                self.tableView.reloadData()
                
                if self.messagesArray.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.messagesArray.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if messageTextField.text != "" {
            messageTextField.isEnabled = false
            sendButton.isEnabled = false
            
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key, sendComplete: { (complete) in
                if complete {
                    self.messageTextField.isEnabled = true
                    self.sendButton.isEnabled = true
                    self.messageTextField.text = ""
                }
            })
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        
        let message = messagesArray[indexPath.row]
        
        DataService.instance.getUserName(forUID: message.senderID) { (email) in
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        
        return cell
    }
    
}
