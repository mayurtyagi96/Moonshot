//
//  AstronautView.swift
//  Moonshot
//
//  Created by Mayur  on 30/07/24.
//

import SwiftUI

struct AstronautView: View {
    var astronaut: Astronaut
    
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return AstronautView(astronaut: astronauts["white"]!)
        .preferredColorScheme(.dark)
}
