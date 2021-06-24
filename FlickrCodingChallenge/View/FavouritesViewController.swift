//
//  FavouritesViewController.swift
//  FlickrCodingChallenge
//
//  Created by Abilash Francis on 23/6/21.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    lazy var viewModel: FavouritesViewModel = {
        return FavouritesViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.favouritesCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.initPhotoList()
    }

    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteCell", for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("Cell does not exist in Storyboard !!")
        }

        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.photoCollectionCellViewModel = cellVM

        return cell
    }


}
