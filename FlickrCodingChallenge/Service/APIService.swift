//
//  APIService.swift
//  FlickrCodingChallenge
//
//  Created by Abilash Francis on 23/6/21.
//

import Foundation

protocol APIServiceProtocol {
    func fetchFlickrPhotos( complete: @escaping ( _ success: Bool, _ photos: [Photo]?, _ error: Error? )->() )
}

class APIService: APIServiceProtocol {
    
    func fetchFlickrPhotos( complete: @escaping ( _ success: Bool, _ photos: [Photo]?, _ error: Error? )->() ) {
        DispatchQueue.global().async {
            
            let flickrEndpoint = "https://www.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=7732458156fcaeb7297691b8341818b2&user_id=65789667@N06&extras=url_m,owner_name&format=json&nojsoncallback=1"
            let request = URLRequest(url: URL(string: flickrEndpoint)!)
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
                
                if let error = error {
                    complete(false, nil, error)
                }
                
                if let data = data {
                    let photos = try? JSONDecoder().decode(PhotosJSON.self, from: data)
                    complete(true, (photos?.photos.photo), nil )
                }
            })

            task.resume()
        }
    }
    
}
