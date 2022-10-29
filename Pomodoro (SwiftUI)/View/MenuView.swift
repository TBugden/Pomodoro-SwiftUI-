//
//  MenuView.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/27/22.
//

import SwiftUI

struct MenuView: View {
    @Binding var isShowingMenu: Bool
    @Binding var tabSelection: Int
    
    @State var isShowingAlert = false
    @State var visible = false
    
    let width = UIScreen.main.bounds.width / 2.25
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 35) {
                Text("Menu")
                    .font(.title)
                    .fontWeight(.light)
                    .padding(.top, 50)
                ForEach(PomodoroMenuButton.allCases) { button in
                    MenuButton(button)
                }
                Spacer()
                Button {
                    isShowingAlert = true
                } label: {
                    Label("Log Out", systemImage: "arrow.forward.circle")
                        .fontWeight(.semibold)
                        .padding()
                        .background(.black.opacity(0.1))
                        .cornerRadius(.infinity)
                }
            }
            .frame(width: width)
            .background(LinearGradient(colors: [Color.customMutedGreenLight, Color.customMutedGreenDark], startPoint: .topLeading, endPoint: .bottomTrailing))
            .offset(x: visible ? 0 : -width)
            Spacer()
        }
        .onTapBackground(enabled: isShowingMenu) {
            withAnimation(.linear(duration: 0.15)) {
                visible = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                isShowingMenu = false
            }
        }
        .background(.ultraThinMaterial.opacity(visible ? 1 : 0 ))
        .foregroundColor(.white)
        .onAppear {
            withAnimation(.linear(duration: 0.15)) {
                visible = true
            }
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Are you sure you want to sign out?"), primaryButton: .destructive(Text("Sign Out"), action: {  }), secondaryButton: .cancel())
        }
    }
    
    @ViewBuilder
    func MenuButton(_ button: PomodoroMenuButton) -> some View {
        Button {
            tabSelection = button.tag
            withAnimation {
                visible = false
            }
        } label: {
            HStack {
                Image(systemName: button.systemIcon)
                        .frame(width: 30)
                Text(button.title)
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isShowingMenu: .constant(true), tabSelection: .constant(0))
    }
}
