//
//  Router+Generic.swift
//  Router
//
//  Created by ganesh shankar on 11/09/25.
//

import Foundation
import SwiftUI

// enum for Diffrent Views
enum AppRoute: Hashable {
    case home
    case profile
    case detail(id: Int)
}

@MainActor
@Observable
final class Router {
    var path = NavigationPath()
    
    // MARK: - Creat the array which we use to reach to given screen
    private(set) var routeStack: [AppRoute] = []
    
    // MARK: - Navigation actions
    
    //MARK: - Navigate forward to a route
    func navigate(to route: AppRoute) {
        routeStack.append(route)        // update our stack of with path
        path.append(route)              // update NavigationPath (UI)
    }
    
    //MARK: - Going back to one screen back , Pop one level
    func goBack() {
        guard !routeStack.isEmpty else { return }
        routeStack.removeLast()
        if !path.isEmpty { path.removeLast() }
    }
    
    //MARK: -  Go home (clear everything)
    func goHome() {
        routeStack.removeAll()
        path.removeLast(path.count)
    }
    
    //MARK: - Go back until the specified route appears as the top (if found).
    /// If route is not found, does nothing
    
    func goBack(to route: AppRoute) {
        guard let index = routeStack.lastIndex(of: route) else { return }
        
        // MARK: - number of items after that index
        
        let removeCount = routeStack.count - (index + 1)
        guard removeCount > 0 else { return }  // already on the target
        
        // MARK: - update both stack and NavigationPath
        
        routeStack.removeLast(removeCount)
        path.removeLast(removeCount)
    }
    
    // MARK: - Replace the entire stack (optional helper)
    
    func setStack(_ newStack: [AppRoute]) {
        routeStack = newStack
        var newPath = NavigationPath()
        for r in newStack { newPath.append(r) }
        path = newPath
    }
}

