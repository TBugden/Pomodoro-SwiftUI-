//
//  CoreDataControlelr.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/28/22.
//

import CoreData

class CoreDataController: ObservableObject {
    static let shared: CoreDataController = CoreDataController()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "Pomodoro")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            print(error)
        }
    }
}
