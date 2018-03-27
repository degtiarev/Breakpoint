//
//  CreateGroupsVC.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 26/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import UIKit

class CreateGroupsVC: UIViewController {
    
    @IBOutlet weak var tittleTextField: InsertTextField!
    @IBOutlet weak var descriptionTextField: InsertTextField!
    @IBOutlet weak var emailSearchTextField: InsertTextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var groupMemberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var emailArray = [String]()
    var selectedEmailArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        doneButton.isHidden = true
    }
    
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange() {
        if emailSearchTextField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }
    
}




extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        
        if selectedEmailArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        
        if !selectedEmailArray.contains(cell.emailLabel.text!) {
            selectedEmailArray.append(cell.emailLabel.text!)
            
            groupMemberLabel.text = selectedEmailArray.joined(separator: " ,")
            doneButton.isHidden = false
            
        } else {
            // return all with the exceptin of selected cell
            selectedEmailArray = selectedEmailArray.filter({ $0 != cell.emailLabel.text })
            
            if selectedEmailArray.count >= 1 {
                groupMemberLabel.text = selectedEmailArray.joined(separator: ", ")
            } else {
                groupMemberLabel.text = "ADD PEOPLE TO YOUR GROUP"
                doneButton.isHidden = true
            }
            
        }
    } // func tableView(_ tab$leView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
}


//extension CreateGroupsVC: UITextFieldDelegate {
//
//
//
//}

