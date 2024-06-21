//
//  BaseAPI.swift
//  NetworkModule
//
//  Created by J Andrean on 19/06/24.
//

import Combine
import Foundation
import InjectorModule

public protocol BaseAPI {}

public extension BaseAPI {
    var context: ServiceContext { Injector.shared.resolve() }
    var session: URLSession { URLSession.shared }
    var baseURLString: String { context.urlString }
    var defaultHeader: [String: String] { context.defaultHeader }
    
    func request<Response: Codable>(
        _ method: HTTPMethod,
        path: String,
        headers: [String: String] = [:],
//        parameters: [String: Any] = [:]) -> AnyPublisher<BaseResponse<Response>, Error>
        parameters: [String: Any] = [:]) -> AnyPublisher<Response, Error>
    {
        guard var urlComponents = URLComponents(string: baseURLString) else {
            return errorPublisher(.urlError)
        }
        
        urlComponents.path = path
        urlComponents.queryItems = parameters
            .map { parameter -> URLQueryItem in
                return .init(
                    name: parameter.key,
                    value: "\(parameter.value)"
                )
            }
        
        guard let url = urlComponents.url else {
            return errorPublisher(.urlError)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        defaultHeader.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        headers.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.responseError
                }
                return data
            }
//            .decode(type: BaseResponse<Response>.self, decoder: JSONDecoder())
            .decode(type: Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func errorPublisher<T>(_ error: APIError) -> AnyPublisher<T, Error> {
        return Fail(error: error).eraseToAnyPublisher()
    }
}
