//
//  Bundle-Secodable.swift
//  Moonshot
//
//  Created by Mayur  on 29/07/24.
//

import Foundation

extension Bundle{
    func decode<T: Codable>(_ file: String) -> T{
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        do{
            return try decoder.decode(T.self, from: data)
        }catch DecodingError.keyNotFound(let key, let context) {
            fatalError("missing key \(key.stringValue) - \(context.debugDescription)")
        }catch DecodingError.valueNotFound(_ , let context){
            fatalError("value not found - \(context.debugDescription)")
        }catch DecodingError.typeMismatch(let type, let context){
            fatalError("type mismatched \(type) \(file) - \(context.debugDescription)")
        }catch DecodingError.dataCorrupted(let context){
            fatalError("data is corrupted \(context.debugDescription) might be invaalid JSON")
        }catch{
            fatalError(error.localizedDescription)
        }
            
    }
}

