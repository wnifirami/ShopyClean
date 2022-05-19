//
//  KeychainStorage.swift
//  Core
//
//  Created by Rami Ounifi on 18/5/2022.
//

import Foundation
import SwiftUI
import SwiftKeychainWrapper
import Combine

public enum KeychainStorage {
   public static let key = "credentials"
    
   public  static func getCredentials()  -> AnyPublisher<RegisterResponse?, KeyChainError>{
        if let myCredentialsData = KeychainWrapper.standard.string(forKey: Self.key) {
            return Result<RegisterResponse?, KeyChainError>.Publisher(Bundle.main.decode(myCredentialsData)).eraseToAnyPublisher()
        } else {
            return AnyPublisher(
                Fail<RegisterResponse?, KeyChainError>(error: KeyChainError.notfound)
            )
        }
    }

   public  static func saveCredentials(_ credentials: RegisterResponse) ->  AnyPublisher<Bool, Never> {
        guard let data = try? Bundle.main.encode(credentials) else {
            return Just(false).eraseToAnyPublisher()
        }
        if KeychainWrapper.standard.set(data, forKey: Self.key) {
            return Just(true).eraseToAnyPublisher()
        } else {
            return Just(false).eraseToAnyPublisher()
        }
    }

   public static func deleteCredentials() -> AnyPublisher<Bool, Never> {
        @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
        if KeychainWrapper.standard.removeObject(forKey: Self.key) {
            isLoggedIn = false
            return Just(true).eraseToAnyPublisher()
        } else {
            return Just(false).eraseToAnyPublisher()

        }
    }
}

public enum KeyChainError: Error {
    case notfound
    case notsaved
}

