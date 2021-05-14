//
//  URL+Queries.swift
//  NASA
//
//  Created by x.sargsyan on 2/12/20.
//  Copyright © 2020 SwiftAcademy. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents.init(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map{URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
    }
}
