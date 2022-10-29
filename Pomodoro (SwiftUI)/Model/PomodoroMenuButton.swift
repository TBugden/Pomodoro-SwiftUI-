//
//  PomodoroMenuButton.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/29/22.
//

import Foundation

enum PomodoroMenuButton: Identifiable, CaseIterable {
    var id: Self { return self }
    
    case history, achievements, friends, settings
    
    var systemIcon: String {
        switch self {
        case .history:
            return "list.bullet.clipboard"
        case .achievements:
            return "medal"
        case .settings:
            return "gearshape"
        case .friends:
            return "person.2"
        }
    }
    
    var title: String {
        switch self {
        case .history:
            return "History"
        case .achievements:
            return "Achievements"
        case .settings:
            return "Settings"
        case .friends:
            return "Friends"
        }
    }
    
    var tag: Int {
        switch self {
        case .history:
            return 1
        case .achievements:
            return 2
        case .friends:
            return 3
        case .settings:
            return 4
        }
    }
}
