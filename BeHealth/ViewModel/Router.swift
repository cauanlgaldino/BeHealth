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
        case login
        case feed
        case settings
        case contentView
        case searchView
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
