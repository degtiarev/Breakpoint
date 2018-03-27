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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        cell.configureCell(profileImage: profileImage!, email: "adawkldaw", isSelected: true)
        
        return cell
    }
    
}
