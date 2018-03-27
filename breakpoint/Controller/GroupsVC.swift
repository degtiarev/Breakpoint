//
//  SecondViewController.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 24/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}


extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell()}
        cell.configureCell(tittle: "tittle", description: "description", memberCount: 3)
        return cell
    }
    
}

