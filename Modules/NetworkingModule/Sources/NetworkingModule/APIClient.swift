//  APIClient.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation

public struct EmptyRequest: Codable {
    public init() {}
}

public enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

public enum NetworkError: Error {
    case noRequestObject
    case unknownError
    case noData
    case errorInURL
}

public protocol APIClient {
    func makeRequest<T: Codable, K: Codable>(pathURL: String, method: HTTPMethod, responseType: T.Type, requestBody: K, queryParameters: [URLQueryItem]) async throws -> T
}

public extension APIClient where Self: Any {
    func makeRequest<T: Codable, K: Codable>(pathURL: String, method: HTTPMethod = .get, responseType: T.Type, requestBody: K = EmptyRequest(), queryParameters: [URLQueryItem]) async throws -> T {
        guard let encodedRequestObject = try? JSONEncoder().encode(requestBody) else {
            print("Failed to encode order")
            throw NetworkError.noRequestObject
        }
        let urlComponents = self.generateUrlComponent(url: pathURL, queries: queryParameters)
        var request = URLRequest(url:  urlComponents.url!, cachePolicy: .useProtocolCachePolicy)
        request.initWithBasic()
        request.httpMethod = method.rawValue
        if method != .get {
            request.httpBody = encodedRequestObject
        }
        let session = URLSession.shared
        let (data, response) = try await session.data(for: request)
        let responseCode = (response as? HTTPURLResponse)?.statusCode ?? 400
        if (200...299).contains(responseCode) {
            let decodedObject = try JSONDecoder().decode(responseType.self, from: data)
            return decodedObject
        } else {
            throw NetworkError.unknownError
        }
    }
    
    private func generateUrlComponent(url: String, queries: [URLQueryItem]) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = APIEnvironment.getHost()
        urlComponents.path = url
        urlComponents.queryItems = queries
        return urlComponents
    }
}

extension URLRequest {
    mutating func initWithBasic() {
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}

open class APIService: APIClient {
    public init() {}
}
