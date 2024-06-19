//
//  BaseResponse.swift
//  NetworkModule
//
//  Created by J Andrean on 19/06/24.
//

import Foundation

public typealias APIResult<Object: Codable> = Result<BaseResponse<Object>, APIError>

public struct BaseResponse<ResponseData: Codable>: Codable {
    public let data: ResponseData?
    public let error: ResponseError?
    
    public init(data: ResponseData?, error: ResponseError?) {
        self.data = data
        self.error = error
    }
}

public struct ResponseError: Codable, Error {
    public let code: String
    public let message: String
}
