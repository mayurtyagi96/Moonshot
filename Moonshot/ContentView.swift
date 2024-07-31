//
//  ContentView.swift
//  Moonshot
//
//  Created by Mayur on 28/07/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    @State private var gridViewVisible: Bool = false
    
    var body: some View {
        NavigationStack{
            Group{
                if gridViewVisible{
                    GridView(mission: mission, astronauts: astronauts)
                }else{
                    ListView(mission: mission, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .toolbar(content: {
                Button(gridViewVisible ? "Show List" : "Show Grid"){
                    gridViewVisible.toggle()
                }
            })
            .preferredColorScheme(.dark)
        }
    }
}

struct GridView: View {
    var mission: [Mission]
    var astronauts: [String: Astronaut]
    
    let column = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: column) {
                ForEach(mission){ mission in
                    NavigationLink{
                        MissionView(mission: mission, astranouts: astronauts)
                    } label: {
                        VStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack{
                                Text(mission.displayName)
                                    .font(. headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                        
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListView: View {
    var mission: [Mission]
    var astronauts: [String: Astronaut]
    var body: some View {
            List(mission){ mission in
                NavigationLink(mission.displayName){
                    MissionView(mission: mission, astranouts: astronauts)
                }
                .listRowBackground(Color.darkBackground)
            }
            .listStyle(.plain)
    }
}

#Preview {
    ContentView()
}
