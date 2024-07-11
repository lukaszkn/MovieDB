//
//  MovieListCollectionViewCell.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//
//  This is code behind for movie list item

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    /// Configure cell content controls
    func configureCellContent(movie: Movie) {
        posterImage.sd_setImage(with: TMDBEndpoint.posterImageUrl(path: movie.posterPath ?? ""))
        
        favButton.setImage(UIImage(systemName: /*isFavourite ? "star.fill" :*/ "star") ?? UIImage(), for: .normal)
    }
    
    /// Called when favourite button is tapped
    @IBAction func favButtonTapped() {
    }
}
