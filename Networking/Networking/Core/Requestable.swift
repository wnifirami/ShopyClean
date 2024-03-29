//
//  Requestable.swift
//  Networking
//
//  Created by Rami Ounifi on 18/5/2022.
//

import Combine
import Foundation

public struct NativeRequestable {

    public static func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
     where T: Decodable, T: Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? 30)
        
        guard let url = URL(string: req.url) else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL("Invalid Url"))
            )
        }
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { output in
                     // throw an error if response is nil
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                return output.data
            }
            .handleEvents(receiveOutput: { data in
                          print(String(data: data, encoding: .utf8))
                       })
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                       // return error if json decoding fails
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}
