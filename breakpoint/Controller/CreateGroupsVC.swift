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
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
