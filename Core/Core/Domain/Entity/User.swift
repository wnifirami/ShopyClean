//
//  User.swift
//  Core
//
//  Created by Rami Ounifi on 18/5/2022.
//

import Foundation

// MARK: - User
public struct User: Codable {
    public let id, name, email, role: String
    public let createdAt, token: String

     enum CodingKeys: String, CodingKey {
         case id = "_id"
         case name, email, role, createdAt, token
     }
}

public struct RegisterRequest: Codable {
    public let name, email, password: String
    public let age: Int
}

public struct LoginRequest: Codable {
    public let email, password: String
}

public struct RegisterResponse: Codable {
    public let user: User
    public let token: String
}

