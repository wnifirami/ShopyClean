//
//  LoginUseCase.swift
//  StoreAppSample
//
//  Created by Rami Ounifi on 18/5/2022.
//

import Foundation
import Infrastructure
import Combine
import Core
import Networking

protocol LoginUseCaseProtocol {
    func execute(requestValue: LoginRequest)  -> AnyPublisher<RegisterResponse, NetworkError>
    func saveUser(requestValue: RegisterResponse)  -> AnyPublisher<Bool, Never>
    func getUser() -> AnyPublisher<RegisterResponse?, KeyChainError>
}



class LoginUseCase: LoginUseCaseProtocol {
    func getUser() -> AnyPublisher<RegisterResponse?, KeyChainError> {
        return registerRepository.getUserData()
    }
    
    func saveUser(requestValue: RegisterResponse) -> AnyPublisher<Bool, Never> {
       return registerRepository.saveUserData(request: requestValue)
    }
    

    private let registerRepository: AuthentificationRepositoryProtocol

    init(
        registerRepository: AuthentificationRepositoryProtocol
       ) {

        self.registerRepository = registerRepository
    }

    func execute(requestValue: LoginRequest)  -> AnyPublisher<RegisterResponse, NetworkError> {
        registerRepository.LoginUser(request: requestValue)
    }
}
