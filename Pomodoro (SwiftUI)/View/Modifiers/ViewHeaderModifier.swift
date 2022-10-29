//
//  ViewHeaderModifier.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/29/22.
//

import SwiftUI

struct ViewHeaderModifier: ViewModifier {
    
    @Binding var tabSelection: Int
    
    let title: String
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        tabSelection = 0
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            Text(title)
                .font(.title)
                .fontWeight(.light)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 25)
                .padding(.bottom, 10)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.linearGradient(colors: [.clear, .white, .clear], startPoint: .leading, endPoint: .trailing))
                .padding(.horizontal)
            ScrollView {
                content
            }
        }
        .foregroundColor(.white)
        .background(LinearGradient(colors: [Color.customMutedGreenLight, Color.customMutedGreenDark], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct ViewHeaderModifier_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tabSelection: .constant(0))
    }
}
