 //
 //  GroupCell.swift
 //  breakpoint
 //
 //  Created by Aleksei Degtiarev on 27/03/2018.
 //  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
 //
 
 import UIKit
 
 class GroupCell: UITableViewCell {
    
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var groupDescriptionLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    
    
    func configureCell(tittle: String, description: String, memberCount: Int) {
        self.groupDescriptionLabel.text = tittle
        self.groupDescriptionLabel.text = description
        self.memberCountLabel.text = "\(memberCount) members."
    }
 }
