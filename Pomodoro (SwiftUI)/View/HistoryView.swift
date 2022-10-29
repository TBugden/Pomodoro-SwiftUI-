//
//  TimerView.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/28/22.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var pomoHistory: FetchedResults<Pomodoro>
    @Binding var tabSelection: Int
    
    var body: some View {
        LazyVStack {
            ForEach(pomoHistory, id: \.date) { pomo in
                HistoryItem(
                    imageName: pomo.image ?? "Sprout",
                    date: pomo.date ?? Date(),
                    duration: Int(pomo.duration),
                    completed: pomo.completed)
            }
        }
        .padding(.top)
        .fontWeight(.bold)
        .font(.caption)
        .modifier(ViewHeaderModifier(tabSelection: $tabSelection, title: "History"))
        
    }
    
    @ViewBuilder
    func HistoryItem(imageName: String, date: Date, duration: Int, completed: Bool) -> some View {
        HStack {
            PlantMedal(imageName: imageName, completed: completed)
            Spacer()
            DetailsView(date: date, duration: duration)
            Spacer()
            Text(completed ? "Completed" : "Failed")
                .opacity(0.75)
        }
        .fontWeight(.bold)
        .font(.caption)
        
        .padding()
        .background(.black.opacity(0.1))
        .cornerRadius(25)
        
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func PlantMedal(imageName: String, completed: Bool) -> some View {
        Circle()
            .shadow(color: .black.opacity(0.5), radius: 5, x: 2.5, y: 2.5)
            .frame(height: 75)
            .foregroundStyle(.linearGradient(colors: [Color.customMutedGreenLight, Color.customMutedGreenDark], startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay {
                Image(imageName)
                    .resizable()
                    .padding(10)
                    .clipped()
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 5))
                    .foregroundStyle(.linearGradient(colors: [Color.customVibrantGreenLight, Color.customVibrantGreenDark], startPoint: .topLeading, endPoint: .bottomTrailing))
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 5))
                    .foregroundStyle(.linearGradient(colors: [.clear, .white, .clear, .white, .clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .opacity(0.25)
                if !completed {
                    Image(systemName: "nosign")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.red)
                        .overlay {
                            Image(systemName: "nosign")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.linearGradient(colors: [.red, .white, .red, .white, . red], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .opacity(0.25)
                        }
                }
                
            }
    }
    
    @ViewBuilder
    func DetailsView(date: Date, duration: Int) -> some View {
        let startTime = Calendar.current.date(byAdding: .minute, value: -duration, to: date) ?? Date()
        
        VStack(alignment: .leading) {
            Text(convertSecondsToMinutes(seconds:duration))
                .font(.headline)
            Text(date.formatted(.dateTime.day().month().year()))
                .opacity(0.5)
            Text(startTime.formatted(.dateTime.hour().minute()) + " - " + date.formatted(.dateTime.hour().minute()))
                .opacity(0.5)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.horizontal)
    }
    
    private func convertSecondsToMinutes(seconds: Int) -> String {
        String(seconds / 60) + " minutes"
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(tabSelection: .constant(0))
        
        HistoryView(tabSelection: .constant(0)).HistoryItem(
            imageName: "sprout",
            date: Date(),
            duration: 25,
            completed: true)
        .padding(.vertical)
        .foregroundColor(.white)
        .background(Color.customMutedGreenLight)
    }
}
