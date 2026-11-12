//
//  CropModel.swift
//  BeHealth
//
//  Created by Cauan Lopes Galdino on 01/09/24.
//

import SwiftUI

enum Crop: Equatable {
    case circle
    case rectangle
    case square
    case custom(CGSize)
    func name() -> String {
        switch self {
        case .circle:
            return "Círculo"
        case .rectangle:
            return "Retângulo"
        case .square:
            return "Quadrado"
        case let .custom(cGSize):
            return "Custom \(Int(cGSize.width))x\(Int(cGSize.height))"
        }
    }
    func size() -> CGSize {
        switch self {
        case .circle:
            return .init(width: 300, height: 300)
        case .rectangle:
            return .init(width: 300, height: 500)
        case .square:
            return.init(width: 300, height: 300)
        case .custom(let cGSize):
            return cGSize
        }
    }
}
