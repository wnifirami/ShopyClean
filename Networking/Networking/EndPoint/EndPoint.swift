//
//  EndPoint.swift
//  Networking
//
//  Created by Rami Ounifi on 18/5/2022.
//

import Foundation
public enum EndPoints {
    /// cases
    case registerUser
    case loginUser
    case getAllTasks

    /// variable path qui retourne l'url a utiliser
    var path: String {
        switch self {
        case .getAllTasks: return "/task"
        case .registerUser: return "/user/register"
        case .loginUser: return "/user/login"
        }
    }
}
/// concatination a l'url de base
extension EndPoints: CustomStringConvertible {
    public var description: String { return AppConfiguration.baseUrl.appending(path)  }
}

