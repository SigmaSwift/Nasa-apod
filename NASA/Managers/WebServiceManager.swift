//
//  WebController.swift
//  NASA
//
//  Created by x.sargsyan on 2/12/20.
//  Copyright © 2020 SwiftAcademy. All rights reserved.
//

import Foundation

class WebServiceManager {
    func getNasaApodFromWeb(completion: @escaping ([Photo]?, Error?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos")!
        let queries = ["api_key": "TmJlTYTSqiNGv9JpbX5u81Qk9ElRk2VRa2gcg6vC",
                       "sol": "1000"]

        let url = baseURL.withQueries(queries)
        
        URLSession.shared.dataTask(with: url!) { (data, respons, error) in
        guard let data = data,
            let nasa = try? JSONDecoder().decode(NasaResponse.self, from: data) else {
                enum MyError: Error {
                    case ParseError
                }
                
                DispatchQueue.main.async {
                    completion(nil, MyError.ParseError)
                }
                return
                
            }
            DispatchQueue.main.async {
                completion(nasa.photos, nil)
            }
        }.resume()
    }
}
