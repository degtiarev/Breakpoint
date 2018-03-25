//
//  Auth.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 25/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping(_ status: Bool, _ error: Error?) ->()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            
            let userData = [ "provider": user.providerID, "email": user.email as Any ] as Dictionary<String,Any>
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
            
        }
    } // func registerUser(withEmail email: ...
    
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) ->()) {
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
            
        }
    } // func loginUser(withEmail email:
    
}

