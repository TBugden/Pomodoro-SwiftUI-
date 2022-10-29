//
//  Achievement.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/29/22.
//

import Foundation

enum Achievement: Identifiable, CaseIterable {
    var id: Self { return self }
    
    case onePlant, fivePlants, tenPlants, hundredPlants
    
    var systemIcon: String {
        switch self {
        case .onePlant:
            return "leaf.fill"
        case .fivePlants:
            return "camera.macro"
        case .tenPlants:
            return "carrot.fill"
        case .hundredPlants:
            return "dumbbell.fill"
        }
    }
    
    var title: String {
        switch self {
        case .onePlant:
            return "First Timer"
        case .fivePlants:
            return "Gardener"
        case .tenPlants:
            return "Farmer"
        case .hundredPlants:
            return "Competitive"
        }
    }
    
    var description: String {
        switch self {
        case .onePlant:
            return "Complete your first pomodoro."
        case .fivePlants:
            return "Complete 5 pomodoros."
        case .tenPlants:
            return "Complete 10 pomodoros in one day."
        case .hundredPlants:
            return "Complete 100 pomodoros in a month."
        }
    }
    
    var goal: Int {
        switch self {
        case .onePlant:
            return 1
        case .fivePlants:
            return 5
        case .tenPlants:
            return 10
        case .hundredPlants:
            return 100
        }
    }
}
