//
//  Request+Responce.swift
//  Router
//
//  Created by ganesh shankar on 09/09/25.
//

// MARK: - Models
//struct User: Decodable, Identifiable {
//    let id: Int
//    let name: String
//    let email: String
//}
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
    let lng: String
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}


struct Post: Codable, Identifiable {
    let id: Int?
    let userId: Int
    let title: String
    let body: String
}
//struct Post: Codable {
//    let userId: Int
//    let id: Int?
//    let title: String
//    let body: String
//}
