//
//  AppConfiguration.swift
//  Networking
//
//  Created by Rami Ounifi on 18/5/2022.
//

import Foundation
import Combine
import Core
public typealias Headers = [String: String]
 struct AppConfiguration {
    

    static let baseUrl: String = {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("url must not be empty in plist")
        }
        return baseUrl
    }()
     
     static func getHeader() -> [String: String] {
         var subscriptions = Set<AnyCancellable>()
         var headers: Headers = [:]
         let _ = KeychainStorage.getCredentials()
             .sink { (completion) in
                 switch completion {
                 case .failure,.finished:
                    break
                 }
             } receiveValue: { result in
                 if let token = result?.token  {
                     headers["Authorization"] = "Bearer " + token
                 }
             }
             .store(in: &subscriptions)


         headers["Content-Type"] = "application/json"
         return headers
     }
    
}
