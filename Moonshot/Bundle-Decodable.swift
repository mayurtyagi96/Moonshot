//
//  Bundle-Secodable.swift
//  Moonshot
//
//  Created by Mayur  on 29/07/24.
//

import Foundation

extension Bundle{
    func decode(_ file: String) -> [String: Astronaut]{
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else{
            fatalError("Failed to decde \(file) from bundle")
        }
        return loaded
    }
}

