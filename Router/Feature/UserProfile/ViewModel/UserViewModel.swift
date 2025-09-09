//
//  UserViewModel.swift
//  Router
//
//  Created by ganesh shankar on 09/09/25.
//

import Foundation

@MainActor
@Observable
final class UserViewModel{
    var users: [User] = []
    var createdPost: Post?
    var errorMessage: String?
    
    // Fetch all posts (example GET)
    func fetchUsers() async {
        do {
            let fetched: [User] = try await NetworkManager.shared.request(
                // JSONPlaceholder /posts gives array of posts, but you can use .user for single
                endpoint: .users,
                body: Optional<Never>.none, //explicitly no body
                responseType: [User].self
            )
            self.users = fetched
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // Create a new post (example POST)
    func createPost() async {
        let newPost = Post(id: nil, userId: 1, title: "Hello SwiftUI", body: "This is a POST request test")
        do {
            let created: Post = try await NetworkManager.shared.request(
                endpoint: .createPost,
                method: .POST,
                body: newPost,
                responseType: Post.self
            )
            self.createdPost = created
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}

