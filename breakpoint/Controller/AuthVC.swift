//
//  AuthVC.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 25/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func signingWithEmailButtonPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func facebookSigningButtonPressed(_ sender: Any) {
    }
    
    @IBAction func googleSigningButtonPressed(_ sender: Any) {
    }
    
}
