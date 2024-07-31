//
//  MissionView.swift
//  Moonshot
//
//  Created by Mayur  on 30/07/24.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    var mission: Mission
    var astranouts: [String: Astronaut]
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView{
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal){ width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                VStack(alignment: .leading){
                    CustomSeparator()
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text("\(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "")")
                        .foregroundStyle(.gray)
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    CustomSeparator()
                    Text("Crew")
                        .font(.title)
                }
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false){
                  CrewView(crew: crew)
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astranouts: [String : Astronaut]) {
        self.mission = mission
        self.astranouts = astranouts
        
        self.crew = mission.crew.map{ member in
            if let astronaut = astranouts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }else{
                fatalError("unbale to find \(member.name) in astronaut json")
            }
        }
    }
}

struct CrewView: View {
    var crew: [MissionView.CrewMember]
    var body: some View {
        HStack{
            ForEach(crew, id: \.role){ crewMember in
                NavigationLink{
                    AstronautView(astronaut: crewMember.astronaut)
                } label: {
                    Image(crewMember.astronaut.id)
                        .resizable()
                        .frame(width: 104, height: 72)
                        .clipShape(.capsule)
                        .overlay(
                            Capsule()
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.white)
                        )
                    VStack(alignment: .leading){
                        Text(crewMember.astronaut.name)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(crewMember.role)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                }
            }
        }
    }
}

struct CustomSeparator: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.bottom, 5)
    }
}

#Preview {
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let astranouts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: mission[0], astranouts: astranouts)
        .preferredColorScheme(.dark)
    
}
