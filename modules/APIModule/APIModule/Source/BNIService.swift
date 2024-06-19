//
//  BNIService.swift
//  APIModule
//
//  Created by J Andrean on 19/06/24.
//

import Combine
import Foundation
import NetworkModule

public protocol BNIService {
    func getTransaction() -> AnyPublisher<BaseResponse<String>, Error>
}

class BNIAPI: BaseAPI, BNIService {
    func getTransaction() -> AnyPublisher<BaseResponse<String>, Error> {
        return request(.get, path: "/bni")
    }
}
