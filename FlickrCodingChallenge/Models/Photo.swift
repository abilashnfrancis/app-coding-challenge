//
//  Photo.swift
//  FlickrCodingChallenge
//
//  Created by Abilash Francis on 23/6/21.
//

import Foundation

struct PhotosJSON: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let photo: [Photo]
}

struct Photo: Codable {
    let id: String
    let ownername: String
    let title: String
    let url_m: String
}
