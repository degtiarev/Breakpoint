//
//  UIViewExt.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 25/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import UIKit

extension UIView {
    
    func bindToKeyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_ :)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification){
        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let begingFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - begingFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            
            self.frame.origin.y += deltaY
            
        }, completion: nil)
    }
    
}


