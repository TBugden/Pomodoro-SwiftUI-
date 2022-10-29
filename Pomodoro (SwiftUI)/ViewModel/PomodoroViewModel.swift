//
//  PomodoroViewModel.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/28/22.
//

import SwiftUI
import Combine
import CoreData

class PomodoroViewModel: ObservableObject {
    let coreDataController = CoreDataController.shared
    
    @AppStorage("currency") var currency: Int = 0
    @AppStorage("selectedTime") var selectedTime: Double = 6
    
    @Published var timeRemaining = 60
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common)
    @Published var connectedTimer: Cancellable? = nil
    @Published var plantImageName = "plantStage1"
    
    @Published var timerIsActive = false
    
    @Published var todaysTotal = 0
    
    let feedback = UIImpactFeedbackGenerator(style: .medium)
    
    func startTimer() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
            feedback.impactOccurred()
            timeRemaining = Int(selectedTime)
            connectedTimer = timer.connect()
            timerIsActive = true
            
        }
    }
    
    func cancelTimer() {
        self.connectedTimer?.cancel()
        addPomoData(completed: false)
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
            feedback.impactOccurred()
            connectedTimer?.cancel()
            timerIsActive = false
        }
    }
    
    @MainActor
    func activeTimeChange() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            self.getPlantImageName()
        } else {
            self.connectedTimer?.cancel()
            self.addPomoData(completed: true)
            
//            self.currency += Int(selectedTime) / 60
            self.currency += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                    self.timerIsActive = false
                }
            }
        } 
    }
    
    enum TimerType {
        case selectedTime
        case timeRemaining
        case totalTimeToday
    }
    
    func secondsToTimerString(_ timerType: TimerType) -> String {
            switch timerType {
            case .selectedTime:
                return convertSecondsToTime(seconds: Int(selectedTime))
            case .timeRemaining:
                return convertSecondsToTime(seconds: Int(timeRemaining))
            case .totalTimeToday:
                let hours = todaysTotal / 3600
                let minutes = todaysTotal / 60
                
                return String(hours) + "h " + String(format: "%02i", minutes) + "m"
            }
    }
    
    func getPlantImageName() {
        let completionPercent = timeRemaining != 0 ? (Double(timeRemaining) / selectedTime) * 100 : 100
        print(completionPercent)
        switch completionPercent {
        case 75..<100:
            plantImageName = "plantStage1"
            print("stage 1")
        case 25..<75:
            plantImageName = "plantStage2"
            print("stage 2")
        case 0..<25:
            plantImageName = "plantStage3"
            print("stage 3")
        default:
            plantImageName = "plantStage3"
        }
    }
    
    @MainActor
    func calculateTodaysTotal() {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        
        let datePredicate = NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [startDate, endDate])
        let completionPredicate = NSPredicate(format: "completed == YES")
        
        let request: NSFetchRequest<Pomodoro> = Pomodoro.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [datePredicate, completionPredicate])
        
        var pomodoros: [Pomodoro] = []
        do {
            pomodoros = try coreDataController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        
        todaysTotal = Int(pomodoros.map { $0.duration }.reduce(0, +))
    }
    
    private func convertSecondsToTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    private func addPomoData(completed: Bool) {
        let newPomo = Pomodoro(context: coreDataController.container.viewContext)
        newPomo.completed = completed
        newPomo.date = Date()
        newPomo.duration = Int32(selectedTime)
        newPomo.image = plantImageName
        
        coreDataController.saveData()
    }
}
