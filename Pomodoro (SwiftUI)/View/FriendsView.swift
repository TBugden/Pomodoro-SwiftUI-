//
//  FriendsView.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/29/22.
//

import SwiftUI

struct FriendsView: View {
    @Binding var tabSelection: Int
    
    var body: some View {
        LazyVStack(spacing: 0) {
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())]) {
                    ForEach(1...20, id: \.self) { friend in
                        FriendGridItem()
                    }
                }
                .padding()
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.linearGradient(colors: [.clear, .white, .clear], startPoint: .leading, endPoint: .trailing))
                .padding(.horizontal)
                .padding(.bottom)
            ForEach(1...10, id: \.self) { friend in
                FriendListItem()
            }
        }
        .modifier(ViewHeaderModifier(tabSelection: $tabSelection, title: "Friends"))
    }
    
    @ViewBuilder
    func FriendGridItem() -> some View {
        VStack {
            FriendIcon()
            Text("Taylor")
                .font(.caption)
                .fontWeight(.bold)
        }
        .frame(height: UIScreen.main.bounds.height / 10)
        .padding(.trailing)
    }
    
    @ViewBuilder
    func FriendListItem() -> some View {
        HStack {
            FriendIcon()
                .frame(height: 75)
            VStack(alignment: .leading) {
                Text("Jason Baller")
                .font(.title3)
                .fontWeight(.semibold)
                Text("25 pomodoros this month")
                    .opacity(0.5)
            }
            .padding()
            Spacer()
            VStack {
                Text("Today:")
                Text("2 pomos")
            }
            .opacity(0.5)
        }
        .fontWeight(.semibold)
        .font(.caption)
        .padding()
    }
    
    @ViewBuilder
    func FriendIcon() -> some View {
        Circle()
            .shadow(color: .black.opacity(0.25),radius: 5, x: 2.5, y: 2.5)
            .foregroundStyle(.linearGradient(colors: [Color.customVibrantGreenLight, Color.customVibrantGreenDark], startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundColor(Color.random)
                    .opacity(0.5)
                    .background(Color.customMutedGreenLight)
                    .cornerRadius(.infinity)
                    .padding(5)
            }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(tabSelection: .constant(0))
    }
}
