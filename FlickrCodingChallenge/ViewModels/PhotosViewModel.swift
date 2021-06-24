//
//  PhotoViewModel.swift
//  FlickrCodingChallenge
//
//  Created by Abilash Francis on 23/6/21.
//

import Foundation

class PhotosViewModel {
    
    let apiService: APIServiceProtocol

    private var photos: [Photo] = [Photo]()
    
    private var cellViewModels: [PhotoCollectionCellViewModel] = [PhotoCollectionCellViewModel]() {
        didSet {
            if self.isReloadNeeded {
                self.reloadCollectionViewClosure?()
            }
        }
    }
    
    var isReloadNeeded: Bool = false

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
            self.processFetchedPhoto(photos: PhotoCache.shared.getCachedPhotos())
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
        
    var reloadCollectionViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchFlickrPhotos { [weak self] (success, photos, error) in
            self?.isReloadNeeded = true
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.localizedDescription + "\nLoading images from last session."
            } else {
                PhotoCache.shared.savePhotos(photos)
                self?.processFetchedPhoto(photos: photos)
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PhotoCollectionCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func isFavouritePhoto(_ photoId: String) -> Bool {
        return PhotoCache.shared.isPhotoAddedToFavourites(photoId)
    }
    
    func createCellViewModel( photo: Photo ) -> PhotoCollectionCellViewModel {
        
        var cellVM = PhotoCollectionCellViewModel(id: photo.id,
                                                  title: photo.title,
                                                  name: photo.ownername,
                                                  imageUrl: photo.url_m,
                                                  isFavourite: isFavouritePhoto(photo.id))
        
        cellVM.updateFavouriteStatus = { [weak self] flag in
            self?.isReloadNeeded = false

            if let row = self?.cellViewModels.firstIndex(where: {$0.id == cellVM.id}) {
                self?.cellViewModels[row].isFavourite = flag
                let selectedPhoto = self!.photos[row]
                
                // Persist favourite photos
                flag ? PhotoCache.shared.addPhotoToFavourites(selectedPhoto) : PhotoCache.shared.removePhotoFromFavourites(selectedPhoto)
            }
        }
        return cellVM
    }
    
    private func processFetchedPhoto(photos: [Photo]?) {
        self.photos = photos ?? [Photo]() // Cache
        var vms = [PhotoCollectionCellViewModel]()
        for photo in self.photos {
            vms.append( createCellViewModel(photo: photo) )
        }
        self.cellViewModels = vms
    }
    
}


