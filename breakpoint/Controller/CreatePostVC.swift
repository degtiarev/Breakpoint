//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 25/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        sendButton.bindToKeyBoard()
    }
    
    
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
        if textView.text != "" && textView.text != "Say something here..." {
            sendButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete {
                    self.sendButton.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendButton.isEnabled = true
                    print("There was an error!")
                }
            })
        }
    }
    
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}




extension CreatePostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
