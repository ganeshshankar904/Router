//
//  NetworkManager.swift
//  Router
//
//  Created by ganesh shankar on 09/09/25.
//

import Foundation

// MARK: - Network Manager
final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let tokenStore = TokenStore()
    
    func request< Body: Encodable, T: Decodable >(
        endpoint: Endpoint,
        method: HTTPMethod = .GET,
        body: Body? = nil,
        headers: [HeaderField: [HeaderValue]] = [:],
        responseType: T.Type,
        retries: Int = 1
    ) async throws -> T {
        
        guard let url = URL(string: endpoint.urlString) else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.timeoutInterval = 60
        
        // Default headers
        urlRequest.setValue(HeaderValue.multiple([.json, .xml]),
                         forHTTPHeaderField: HeaderField.accept.rawValue)
        
        // Auth header
        if let token = await tokenStore.getToken() {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: HeaderField.authorization.rawValue)
        }
        
        // Custom headers
        headers.forEach { key, values in
            urlRequest.setValue(HeaderValue.multiple(values), forHTTPHeaderField: key.rawValue)
        }
        
        // Encode body if exists
        if let body = body {
            do {
                urlRequest.setValue(HeaderValue.json.rawValue,
                                    forHTTPHeaderField: HeaderField.contentType.rawValue)
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw APIError.encodingError(error)
            }
        }
        
        // MARK: - Perform request with bytes streaming
        //let (bytes, response) = try await URLSession.shared.bytes(for: urlRequest)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        // MARK: - Perform request with bytes streaming Collect streamed bytes into Data by appending it
//        var data = Data()
//        for try await chunk in bytes {
//            data.append(chunk)
//        }
        
        // MARK: - Handle Response
        switch httpResponse.statusCode {
        case 200..<300:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingError(error)
            }
        case 401:
            if retries > 0 {
                try await refreshAccessToken()
                return try await self.request(
                    endpoint: endpoint,
                    method: method,
                    body: body,
                    headers: headers,
                    responseType: T.self,
                    retries: retries - 1
                )
            } else {
                throw APIError.unauthorized
            }
        default:
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    private func refreshAccessToken() async throws {
        print("🔄 Refreshing access token...")
        try await Task.sleep(nanoseconds: 1_000_000_000) // simulate delay
        await tokenStore.updateToken("new_fake_token_123")
        print("✅ Token refreshed")
    }
}

// MARK: - Actor for token safety
actor TokenStore {
    private var token: String? = "initial_fake_token"
    
    func getToken() -> String? { token }
    
    func updateToken(_ newToken: String) {
        token = newToken
    }
}

// MARK: - HTTP Method
enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

// MARK: - API Errors
enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case encodingError(Error)
    case unauthorized
    case serverError(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid Response"
        case .decodingError(let err): return "Decoding failed: \(err.localizedDescription)"
        case .encodingError(let err): return "Encoding failed: \(err.localizedDescription)"
        case .unauthorized: return "Unauthorized (401)"
        case .serverError(let code): return "Server Error \(code)"
        }
    }
}

// MARK: - Endpoint
enum Endpoint {
    case user(id: Int)
    case posts
    case users
    case createPost
    
    var urlString: String {
        switch self {
        case .user(let id):
            return "https://jsonplaceholder.typicode.com/users/\(id)"
        case .posts:
            return "https://jsonplaceholder.typicode.com/posts"
        case .users:
            return "https://jsonplaceholder.typicode.com/users"
        case .createPost:
            return "https://jsonplaceholder.typicode.com/posts"
        }
    }
}

// MARK: - Headers
enum HeaderField: String {
    case accept = "Accept"
    case authorization = "Authorization"
    case contentType = "Content-Type"
}

enum HeaderValue: String {
    case json = "application/json"
    case xml = "application/xml"
    case text = "text/plain"
    
    static func multiple(_ values: [HeaderValue]) -> String {
        values.map { $0.rawValue }.joined(separator: ", ")
    }
}

