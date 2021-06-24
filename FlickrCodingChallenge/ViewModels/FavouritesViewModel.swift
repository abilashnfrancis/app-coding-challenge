//
//  FavouritesViewModel.swift
//  FlickrCodingChallenge
//
//  Created by Abilash Francis on 24/6/21.
//

import Foundation

class FavouritesViewModel {
        
    var numberOfCells: Int {
        return PhotoCache.shared.getFavouritesCount()
    }
    
    private var favouritesPhotos: [Photo] {
        return PhotoCache.shared.getFavouritePhotos() ?? [Photo]()
    }
    
    private var cellViewModels: [PhotoCollectionCellViewModel] = [PhotoCollectionCellViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    var reloadCollectionViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    func getCellViewModel( at indexPath: IndexPath ) -> PhotoCollectionCellViewModel {
        return cellViewModels[indexPath.row]
    }
        
    func createCellViewModel( photo: Photo ) -> PhotoCollectionCellViewModel {
        
        var cellVM = PhotoCollectionCellViewModel(id: photo.id, title: photo.title, name: photo.ownername, imageUrl: photo.url_m, isFavourite: true)
        cellVM.updateFavouriteStatus = { [weak self] flag in

            if let row = self?.cellViewModels.firstIndex(where: {$0.id == cellVM.id}) {
                // Selected photo object can be identified using the id, so ignoring rest of the properties
                let selectedPhoto = Photo(id: cellVM.id, ownername: "", title: "", url_m: "")
                PhotoCache.shared.removePhotoFromFavourites(selectedPhoto)
                self?.cellViewModels.remove(at: row)
            }
        }
        return cellVM
    }
    
    func initPhotoList() {
        var vms = [PhotoCollectionCellViewModel]()
        for photo in favouritesPhotos {
            vms.append( createCellViewModel(photo: photo) )
        }
        self.cellViewModels = vms
    }
    
}
