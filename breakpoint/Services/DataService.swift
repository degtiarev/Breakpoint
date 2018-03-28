//
//  DataService.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 24/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        if groupKey != nil {
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderID": uid])
            sendComplete(true)
            
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderID": uid])
            sendComplete(true)
        }
    }
    
    
    func getAllFeedMessages(handler: @escaping(_ messages: [Message]) -> ()) {
        
        var messageArray = [Message]()
        
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as? String
                let senderID = message.childSnapshot(forPath: "senderID").value as? String
                let mes = Message(content: content!, senderID: senderID!)
                messageArray.append(mes)
            }
            
            handler(messageArray)
        }
    }// func getAllFeedMessages(handler: @escaping(_ messages: [Message]) -> ()) {
    
    
    func getAllFeedMessagesForGroup(desiredGroup: Group, handler: @escaping(_ messages: [Message]) -> ()) {
        
        var messageArray = [Message]()
        
        REF_GROUPS.child(desiredGroup.key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else{return}
            
            for message in groupMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderID = message.childSnapshot(forPath: "senderID").value as! String
                let currentMessage = Message(content: content, senderID: senderID)
                
                messageArray.append(currentMessage)
            }
            handler(messageArray)
        }
        
        
    } // func getAllFeedMessagesForGroup(desiredGroup: Group...
    
    
    func getUserName(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else
            { return }
            
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    } // func getUserName(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
    
    
    func getEmail(forSearchQuery query: String, handler: @escaping(_ emailArray: [String]) -> ()) {
        
        var emailArray = [String]()
        
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    } // func getEmail(forSearchQuery query: String, handler: @escaping(_ emailArray: [String]) -> ()) {
    
    
    func getEmailForGroup (group: Group, handler: @escaping (_ emailArray: [String]) -> ()){
        
        var emailArray = [String]()
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let uid = user.key
                
                if group.members.contains(uid){
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
        
    }
    
    
    func getIDs(emails emailArray: [String], handler: @escaping(_ IDArray: [String]) -> ()) {
        
        var IDArray = [String]()
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if emailArray.contains(email){
                    IDArray.append(user.key)
                }
            }
            handler(IDArray)
        }
    } // func getID(forSearchQuery query: String, handler: @escaping(_ IDArray: [String]) -> ()) {
    
    
    func createGroup(withTittle tittle: String, andDescription description: String, forUserIDsArray userIDsArray: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
        
        REF_GROUPS.childByAutoId().updateChildValues(["tittle": tittle, "description": description, "members": userIDsArray])
        handler(true)
    }
    
    
    func getAllGroups(handler: @escaping(_ groupsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for group in groupSnapshot {
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                    let tittle = group.childSnapshot(forPath: "tittle").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    let key = group.key
                    
                    let group = Group(tittle: tittle, description: description, key: key, members: memberArray)
                    groupsArray.append(group)
                    
                }
            } // for group in groupSnapshot {
            handler(groupsArray)
        }
    } // func getAllGroups(handler: @escaping(_ groupsArray: [Group]) -> ()) {
    
    
    
}
