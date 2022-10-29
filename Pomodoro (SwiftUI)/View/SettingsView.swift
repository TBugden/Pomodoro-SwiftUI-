//
//  SettingsView.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/29/22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var tabSelection: Int
    @State var toggleBool = false
    
    var body: some View {
        VStack {
            ForEach(1...5, id: \.self) { setting in
                HStack {
                    Text("test")
                    Spacer()
                    Toggle("", isOn: $toggleBool)
                }
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
        .padding(.top)
        .modifier(ViewHeaderModifier(tabSelection: $tabSelection, title: "Settings"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tabSelection: .constant(0))
    }
}
