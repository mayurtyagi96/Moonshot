//
//  Mission.swift
//  Moonshot
//
//  Created by Mayur on 29/07/24.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable{
        var name: String
        var role: String
    }
    
    var id: Int
    var crew: [CrewRole]
    var launchDate: Date?
    var description: String
    
    var displayName: String{
        "apollo \(id)"
    }
    
    var image: String{
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String{
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
