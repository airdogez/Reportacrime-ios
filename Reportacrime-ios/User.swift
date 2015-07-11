//
//  User.swift
//  Reportacrime-ios
//
//  Created by Andres Revolledo on 7/10/15.
//  Copyright (c) 2015 Andres Revolledo. All rights reserved.
//

import Foundation

class User {
    let name: String
    let lastname: String
    let email: String
    let token: String
    let id: Int
    
    init(name: String, lastname: String, email: String, token: String, id: Int){
        self.name = name;
        self.lastname = lastname
        self.email = email;
        self.token = token;
        self.id = id;
    }
    
}