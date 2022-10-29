//
//  TimerSettings.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/27/22.
//

import SwiftUI

struct TimerSettings: View {
    @Binding var selectedTime: Double
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Selected Duration:")
                    .font(.title)
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
                Text(convertSecondsToTimer(seconds:Int(selectedTime)))
                    .font(.system(size: 45))
                    .italic()
                    .minimumScaleFactor(0.75)
            }
            .padding()
            Spacer()
            HStack {
                Button {
                    selectedTime = 10
                } label: {
                    Text("0:10")
                }
                .padding()
                .frame(width: 150)
                .background(.black.opacity(0.1))
                .cornerRadius(.infinity)
                
                Button {
                    selectedTime = 600
                } label: {
                    Text("10:00")
                }
                .padding()
                .frame(width: 150)
                .background(.black.opacity(0.1))
                .cornerRadius(.infinity)
            }
            HStack {
                Button {
                    selectedTime = 1500
                } label: {
                    Text("25:00")
                }
                .padding()
                .frame(width: 150)
                .background(.black.opacity(0.1))
                .cornerRadius(.infinity)
                
                Button {
                    selectedTime = 3600
                } label: {
                    Text("60:00")
                }
                .padding()
                .frame(width: 150)
                .background(.black.opacity(0.1))
                .cornerRadius(.infinity)
            }
            Spacer()
            Slider(value: $selectedTime, in: 300...3600, step: 300.0)
                .tint(Color.customVibrantGreenLight)
                .padding()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(LinearGradient(colors: [Color.customMutedGreenLight, Color.customMutedGreenDark], startPoint: .topLeading, endPoint: .bottomTrailing))
        .foregroundColor(.white)
        .font(.title)
        .fontWeight(.bold)
    }
    
    func convertSecondsToTimer(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

struct TimerSettings_Previews: PreviewProvider {
    static var previews: some View {
        TimerSettings(selectedTime: .constant(25))
            .previewLayout(.fixed(width: 450, height: 350))
    }
}
