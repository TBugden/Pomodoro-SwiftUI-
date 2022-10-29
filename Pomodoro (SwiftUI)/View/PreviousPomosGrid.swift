//
//  PreviousPomosGrid.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/28/22.
//

import SwiftUI

struct PreviousPomosGrid: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                
            }
        }
    }
}

struct PreviousPomosGrid_Previews: PreviewProvider {
    static var previews: some View {
        PreviousPomosGrid()
    }
}
