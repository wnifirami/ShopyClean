//
//  UserServices.swift
//  Infrastructure
//
//  Created by Rami Ounifi on 18/5/2022.
//

import Foundation
import Networking
import Core
// if you wish you can have multiple services like this in a project
enum AuthentificationServiceEndpoints {
    
  // organise all the end points here for clarity
    case registerUser(request: RegisterRequest)
    case loginUser(request: LoginRequest)
    

  //specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .registerUser, .loginUser:
            return .POST
        }
    }
    
  // compose the NetworkRequest
    func createRequest() -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
  // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .registerUser(let request):
            return request
        case .loginUser(let request):
            return request
        }
    }
    
  // compose urls for each request
    func getURL() -> String {
        switch self {
        case .registerUser:
            return EndPoints.registerUser.description
        case .loginUser:
            return EndPoints.loginUser.description
        }
    }
}

