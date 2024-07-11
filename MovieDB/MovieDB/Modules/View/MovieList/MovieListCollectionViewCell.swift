//
//  MovieListCollectionViewCell.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//
//  Code behind for movie list item

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    /// Reference to movie poster
    @IBOutlet weak var posterImage: UIImageView!
    /// Reference for favourite button
    @IBOutlet weak var favButton: UIButton!
    
    /// Reference to movie model also containing favourite state
    var movieModel: MovieModel!
    /// Reference to parent view model
    var parentViewModel: MovieListViewModel!
    
    /// Configure cell content controls
    func updateCellContent(movieModel: MovieModel, parentViewModel: MovieListViewModel) {
        self.movieModel = movieModel
        self.parentViewModel = parentViewModel
        
        /// Set poster image
        posterImage.sd_setImage(with: TMDBEndpoint.posterImageUrl(path: movieModel.movie.posterPath ?? ""))
        
        updateFavButton(isFavourite: movieModel.isFavourite)
    }
    
    /// Update favourite button image depending on state
    private func updateFavButton(isFavourite: Bool) {
        favButton.setImage(UIImage(systemName: isFavourite ? "star.fill" : "star") ?? UIImage(), for: .normal)
    }
    
    /// Called when favourite button is tapped
    @IBAction func favButtonTapped() {
        /// Toggle movie favourite state in parent view model
        parentViewModel.toggleFavouriteStatus(movieModel: movieModel)
        
        /// Refresh button image
        updateFavButton(isFavourite: movieModel.isFavourite)
    }
}
