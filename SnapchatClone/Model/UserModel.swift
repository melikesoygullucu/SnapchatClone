//
//  UserModel.swift
//  SnapchatClone
//
//  Created by Melike Soygüllücü on 4.08.2024.
//

import Foundation


class UserModel {
    
    static let sharedUserInfo = UserModel()
    
    var email = ""
    var username = ""
    
    private init() {
        
    }
}
