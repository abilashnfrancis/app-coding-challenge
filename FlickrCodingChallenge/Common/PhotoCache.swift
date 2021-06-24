//
//  Favourite.swift
//  FlickrCodingChallenge
//
//  Created by Abilash Francis on 24/6/21.
//

import Foundation

class PhotoCache {
    
    static let shared = PhotoCache()
    
    private let favouritesKey = "favourites"
    private let photosKey = "photos_cache"
    
    func saveFavouriteList(_ photos: [Photo]) {
        UserDefaults.standard.set(try? JSONEncoder().encode(photos), forKey: favouritesKey)
    }
    
    func getFavouritePhotos() -> [Photo]? {
        if let decoded  = UserDefaults.standard.value(forKey: favouritesKey) as? Data,
           let favoritesDefaults = try? JSONDecoder().decode([Photo].self, from: decoded) {
            return favoritesDefaults
        }
        return nil
    }
    
    func getFavouritesCount() -> Int {
        return getFavouritePhotos()?.count ?? 0
    }
    
    func getCachedPhotos() -> [Photo]? {
        if let decoded  = UserDefaults.standard.value(forKey: photosKey) as? Data,
           let favoritesDefaults = try? JSONDecoder().decode([Photo].self, from: decoded) {
            return favoritesDefaults
        }
        return nil
    }
    
    func savePhotos(_ photos: [Photo]?) {
        if let photos = photos {
            UserDefaults.standard.set(try? JSONEncoder().encode(photos), forKey: photosKey)
        }
    }
    
    func addPhotoToFavourites(_ photo: Photo) {
        if var favorites = getFavouritePhotos() {
            favorites.append(photo)
            saveFavouriteList(favorites)
        } else {
            saveFavouriteList([photo])
        }
    }

    func removePhotoFromFavourites(_ photo: Photo) {
        if var favorites = getFavouritePhotos() {
            if let index = favorites.firstIndex(where: {$0.id == photo.id}) {
                favorites.remove(at: index)
                saveFavouriteList(favorites)
            }
        }
    }
    
    func isPhotoAddedToFavourites(_ photoId: String) -> Bool {
        if let photos = getFavouritePhotos() {
            return photos.firstIndex(where: {$0.id == photoId}) != nil
        }
        return false
    }
}
