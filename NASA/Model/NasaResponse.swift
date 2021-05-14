//
//  NasaResponse.swift
//  NASA
//
//  Created by x.sargsyan on 2/19/20.
//  Copyright © 2020 SwiftAcademy. All rights reserved.
//

import Foundation


// MARK: - NasaResponse

struct NasaResponse: Codable {
    let photos: [Photo]
}


// MARK: - Photo

struct Photo: Codable {
    let camera: PhotoCamera
    let imgSrc: URL

    enum CodingKeys: String, CodingKey {
        case  camera
        case imgSrc = "img_src"
    }
}


// MARK: - PhotoCamera

struct PhotoCamera: Codable {
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}


