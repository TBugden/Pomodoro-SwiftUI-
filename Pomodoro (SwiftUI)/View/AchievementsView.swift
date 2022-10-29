//
//  AchievementsView.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/28/22.
//

import SwiftUI

struct AchievementsView: View {
    @Binding var tabSelection: Int
    
    var body: some View {
        LazyVStack {
            ForEach(Achievement.allCases, id: \.id) { achievement in
                HStack {
                    MedalIcon(iconName: achievement.systemIcon)
                    VStack(alignment: .leading) {
                        Text(achievement.title)
                            .font(.headline)
                        Text(achievement.description)
                            .opacity(0.5)
                    }
                    .padding(.horizontal)
                    Spacer()
                    Text("0/" + String(achievement.goal))
                        .opacity(0.5)
                }
                .padding()
                .padding(.horizontal)
            }
        }
        .padding(.top)
        .font(.caption)
        .fontWeight(.medium)
        .modifier(ViewHeaderModifier(tabSelection: $tabSelection, title: "Achievements"))
    }
    
    @ViewBuilder
    func MedalIcon(iconName: String) -> some View {
        let coinColors1 = [Color.customVibrantGreenLight, Color.customVibrantGreenDark]
        let coinColors2 = [Color.customVibrantGreenDark, Color.customVibrantGreenLight]
        
        Circle()
            .shadow(color: .black.opacity(0.5), radius: 5, x: 2.5, y: 2.5)
            .frame(height: 75)
            .foregroundStyle(.linearGradient(
                colors: coinColors2,
                startPoint: .topLeading,
                endPoint: .bottomTrailing))
            .overlay {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(Color.customVibrantGreenLight)
                    .shadow(color: .black.opacity(0.15), radius: 5)
                    .padding()
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 5))
                    .foregroundStyle(.linearGradient(colors: coinColors1, startPoint: .topLeading, endPoint: .bottomTrailing))
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 5))
                    .foregroundStyle(.linearGradient(colors: [.clear, .white, .clear, .clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .opacity(0.25)
            }
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView(tabSelection: .constant(0))
    }
}
