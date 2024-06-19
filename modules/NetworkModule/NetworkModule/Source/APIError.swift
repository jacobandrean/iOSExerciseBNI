//
//  APIError.swift
//  NetworkModule
//
//  Created by J Andrean on 19/06/24.
//

import Foundation

public enum APIError: Error {
    case urlError
    case dataError
    case responseError
    case unknownError
    case decodeError
}
