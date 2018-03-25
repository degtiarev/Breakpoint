//
//  LoginVC.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 25/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: InsertTextField!
    @IBOutlet weak var passwordField: InsertTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    
    @IBAction func signingButtonWasPressed(_ sender: Any) {
        
        if emailField.text != nil && passwordField.text != nil {
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!, loginComplete: { (successLogin, errorLogin) in
                
                if successLogin {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: errorLogin?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (successRegister, errorRegister) in
                    
                    if successRegister {
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (success, nil) in
                            
                            self.dismiss(animated: true, completion: nil)
                            print ("Successfully registered user")
                        })
                    } else {
                        print (String(describing: errorRegister?.localizedDescription))
                    }
                    
                })
                
            })
        }
    } //  @IBAction func signingButtonWasPressed(_ sender: Any) {
    
    
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


extension LoginVC: UITextFieldDelegate {}
