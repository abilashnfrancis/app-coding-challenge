//
//  PhotoCollectionViewCell.swift
//  FlickrCodingChallenge
//
//  Created by Abilash Francis on 23/6/21.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var favouritesButton: UIButton!
    @IBOutlet weak var unFavouriteButton: UIButton!
    
    var photoCollectionCellViewModel: PhotoCollectionCellViewModel? {
        didSet {
            titleLabel.text = photoCollectionCellViewModel?.title
            namelabel.text = photoCollectionCellViewModel?.name
            imageView?.sd_setImage(with: URL(string: photoCollectionCellViewModel?.imageUrl ?? "" ), completed: nil)
            favouritesButton.isHidden = photoCollectionCellViewModel?.isFavourite ?? false
            unFavouriteButton.isHidden = !(photoCollectionCellViewModel?.isFavourite ?? false)
        }
    }
    
    @IBAction func favouritesButtonClicked(_ sender: Any) {
        performFavouriteAction(true)
    }
    
    @IBAction func unFavouriteButtonClicked(_ sender: Any) {
        performFavouriteAction(false)
    }
    
    func performFavouriteAction(_ flag: Bool) {
        favouritesButton.isHidden = flag
        unFavouriteButton.isHidden = !flag
        photoCollectionCellViewModel?.isFavourite = flag
        self.photoCollectionCellViewModel?.updateFavouriteStatus?(flag)
    }
}
