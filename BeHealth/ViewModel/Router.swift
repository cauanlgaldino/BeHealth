//
//  Router.swift
//  BeHealth
//
//  Created by honorio on 31/08/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    public enum Destination: Codable, Hashable {
        case loginView
        case feedView
        case settings
        case contentView
        case searchView
        case createUserView
    }
    @Published var navPath = NavigationPath()
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    func navigateBack() {
        navPath.removeLast()
    }
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
