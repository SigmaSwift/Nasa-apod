//
//  UserDafaults+Data.swift
//  NASA
//
//  Created by x.sargsyan on 2/19/20.
//  Copyright © 2020 SwiftAcademy. All rights reserved.
//

import Foundation

extension UserDefaults {
    func save<T: Encodable>(_ object: T, _ key: String) {
        let data = try! JSONEncoder().encode(object)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func load<T: Decodable>(_ type: T.Type, _ key: String) -> T? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data,
            let object = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        
        return object
    }
}
