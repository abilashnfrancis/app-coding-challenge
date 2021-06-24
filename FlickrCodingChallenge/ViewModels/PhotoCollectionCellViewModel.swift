//
//  PhotoCollectionCellViewModel.swift
//  FlickrCodingChallenge
//
//  Created by Abilash Francis on 23/6/21.
//

import Foundation

struct PhotoCollectionCellViewModel {
    let id: String
    let title: String?
    let name: String
    let imageUrl: String
    
    var isFavourite: Bool
    
    var updateFavouriteStatus: ((Bool)->())?
}
