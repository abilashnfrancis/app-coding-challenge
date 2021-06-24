//
//  FavouritesViewModel.swift
//  FlickrCodingChallenge
//
//  Created by Abilash Francis on 24/6/21.
//

import Foundation

class FavouritesViewModel {
    
    var favourites: [PhotoCollectionCellViewModel] = [PhotoCollectionCellViewModel]()
    
    var numberOfCells: Int {
        return PhotoCache.shared.getFavouritesCount()
    }
    
    var favouritesPhotos: [Photo] {
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
        
        var vmCell = PhotoCollectionCellViewModel(id: photo.id, title: photo.title, name: photo.ownername, imageUrl: photo.url_m, isFavourite: true)
        vmCell.updateFavouriteStatus = { [weak self] flag in

            if let row = self?.cellViewModels.firstIndex(where: {$0.id == vmCell.id}) {
                // Selected photo object can be identified using the id, so ignoring rest of the properties
                let selectedPhoto = Photo(id: vmCell.id, ownername: "", title: "", url_m: "")
                PhotoCache.shared.removePhotoFromFavourites(selectedPhoto)
                self?.cellViewModels.remove(at: row)
            }
        }
        return vmCell
    }
    
    func initPhotoList() {
        var vms = [PhotoCollectionCellViewModel]()
        for photo in favouritesPhotos {
            vms.append( createCellViewModel(photo: photo) )
        }
        self.cellViewModels = vms
    }
    
    func addToFavourites(_ photoCellVM: PhotoCollectionCellViewModel) {
        favourites.append(photoCellVM)
    }
    
    func removeFromFavourites(_ photoCellVM: PhotoCollectionCellViewModel) {
        if let index = favourites.firstIndex(where: {$0.id == photoCellVM.id}) {
            favourites.remove(at: index)
        }
    }
}
