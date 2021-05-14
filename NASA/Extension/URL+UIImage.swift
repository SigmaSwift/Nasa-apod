//
//  URL+UIImage.swift
//  NASA
//
//  Created by x.sargsyan on 2/19/20.
//  Copyright © 2020 SwiftAcademy. All rights reserved.
//

import UIKit
import Foundation

extension URL {
    func loadImage(_ completion: @escaping (UIImage?) -> Void ) {
        var request = URLRequest(url: self)
        request.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil else { return }
            let image = UIImage(data: data)

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
