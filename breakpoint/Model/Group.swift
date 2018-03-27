//
//  Group.swift
//  breakpoint
//
//  Created by Aleksei Degtiarev on 27/03/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import Foundation

class Group {
    private var _groupTittle: String
    private var _groupDescription: String
    private var _key: String
    private var _members: [String]
    
    var groupTittle: String {
        return _groupTittle
    }
    
    var groupDescription: String {
        return _groupDescription
    }
    
    var key: String {
        return _key
    }
    
    var memberCount: Int {
        return _members.count
    }
    
    var members: [String] {
        return _members
    }
    
    init(tittle: String, description: String, key: String, members: [String]) {
        self._groupTittle = tittle
        self._groupDescription = description
        self._key = key
        self._members = members
    }
}
