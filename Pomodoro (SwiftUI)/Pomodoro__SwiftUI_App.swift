//
//  Pomodoro__SwiftUI_App.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/26/22.
//

import SwiftUI

@main
struct Pomodoro__SwiftUI_App: App {
    let coreDataController = CoreDataController.shared
    
    @State var tabSelection = 0
    @State var isShowingMenu = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                TabView(selection: $tabSelection) {
                    PomodoroView(isShowingMenu: $isShowingMenu)
                        .tag(0)
                    HistoryView(tabSelection: $tabSelection)
                        .tag(1)
                        .environment(\.managedObjectContext, coreDataController.container.viewContext)
                    AchievementsView(tabSelection: $tabSelection)
                        .tag(2)
                    FriendsView(tabSelection: $tabSelection)
                        .tag(3)
                    SettingsView(tabSelection: $tabSelection)
                        .tag(4)
                }
                if isShowingMenu {
                    MenuView(isShowingMenu: $isShowingMenu, tabSelection: $tabSelection)
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
