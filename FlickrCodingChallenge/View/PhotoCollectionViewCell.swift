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
//            imageView.load(url: URL(string: (photoCollectionCellViewModel?.imageUrl)!)!)
            favouritesButton.isHidden = photoCollectionCellViewModel?.isFavourite ?? false
            unFavouriteButton.isHidden = !(photoCollectionCellViewModel?.isFavourite ?? false)
        }
    }
    
    @IBAction func favouritesButtonClicked(_ sender: Any) {
        
        favouritesButton.isHidden = true
        unFavouriteButton.isHidden = false
        photoCollectionCellViewModel?.isFavourite = true
        self.photoCollectionCellViewModel?.updateFavouriteStatus?(true)
    }
    
    @IBAction func unFavouriteButtonClicked(_ sender: Any) {
        unFavouriteButton.isHidden = true
        favouritesButton.isHidden = false
        photoCollectionCellViewModel?.isFavourite = false
        self.photoCollectionCellViewModel?.updateFavouriteStatus?(false)
    }
}

//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
