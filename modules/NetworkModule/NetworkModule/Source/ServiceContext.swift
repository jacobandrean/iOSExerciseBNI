//
//  ServiceContext.swift
//  NetworkModule
//
//  Created by J Andrean on 19/06/24.
//

import Foundation

public protocol ServiceContext {
    var urlString: String { get }
    var defaultHeader: [String: String] { get }
}

public class AppServiceContext: ServiceContext {
    public var urlString: String
    public var defaultHeader: [String: String]
    
    public init(urlString: String, defaultHeader: [String : String]) {
        self.urlString = urlString
        self.defaultHeader = defaultHeader
    }
}
