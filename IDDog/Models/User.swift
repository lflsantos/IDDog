//
//  User.swift
//  IDDog
//
//  Created by Lucas Santos on 03/06/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

struct User: Codable{
    let email: String
}

struct LoginResponse: Decodable{
    let user: UserResponse
}
struct UserResponse: Decodable{
    let email: String
    let token: String
}
