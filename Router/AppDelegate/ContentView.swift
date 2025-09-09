//
//  ContentView.swift
//  Router
//
//  Created by ganesh shankar on 07/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let error = vm.errorMessage {
                    Text("❌ Error: \(error)")
                        .foregroundColor(.red)
                }
                
                if !vm.users.isEmpty {
                    List(vm.users) { user in
                        VStack(alignment: .leading) {
                            Text(user.name).font(.headline)
                            Text(user.email).font(.subheadline).foregroundColor(.gray)
                        }
                    }
                }
                
                if let created = vm.createdPost {
                    Text("✅ Post Created: \(created.title)")
                        .foregroundColor(.green)
                        .padding()
                }
                
                HStack {
                    Button("Fetch Users") {
                        Task { await vm.fetchUsers() }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Create Post") {
                        Task { await vm.createPost() }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
            .navigationTitle("Networking Example")
        }
    }
}
