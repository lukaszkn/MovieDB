//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Lukasz on 11/07/2024.
//
//  View controller for Movie details screen

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController, Storyboardable {
    var viewModel: MovieDetailsViewModel!
    weak var coordinator: AppCoordinator?
    
    /// Poster image reference
    @IBOutlet weak var posterImage: UIImageView!
    /// Movie details stack to hold label/vaue rows
    @IBOutlet weak var movieDetailsStack: UIStackView!
    /// Text movie overview
    @IBOutlet weak var movieOverview: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        configureView()
    }
    
    /// Configure movie details view, title, poster image and movie details
    private func configureView() {
        title = viewModel.movieModel.movie.title
        posterImage.sd_setImage(with: TMDBEndpoint.posterImageUrl(path: viewModel.movieModel.movie.posterPath ?? ""))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: favouriteButtonImage,
            style: .plain,
            target: self,
            action: #selector(favouriteButtonTapped)
        )
        
        /// Loop through available movie details
        viewModel.movieModel.movie.details.forEach { (key: String, value: String) in
            let keyLabel = UILabel()
            let valueLabel = UILabel()
            
            keyLabel.textColor = .gray
            valueLabel.textColor = .black
            
            keyLabel.text = key
            valueLabel.text = value
            
            labelsStackView.addArrangedSubview(keyLabel)
            valuesStackView.addArrangedSubview(valueLabel)
        }
        
        movieDetailsStack.addArrangedSubview(labelsStackView)
        movieDetailsStack.addArrangedSubview(valuesStackView)
        
        /// Update movie overview
        movieOverview.numberOfLines = 0
        movieOverview.text = viewModel.movieModel.movie.overview
        movieOverview.sizeToFit() // size label height so it's vertically aligned to label's top
    }
    
    /// Left labels stack
    private let labelsStackView: UIStackView = {
        let verticalFirstStackView = UIStackView()
        verticalFirstStackView.axis = .vertical
        verticalFirstStackView.alignment = .trailing
        verticalFirstStackView.distribution = .fillEqually
        verticalFirstStackView.spacing = 5
        verticalFirstStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalFirstStackView
    }()
    
    /// Right values stack
    private let valuesStackView: UIStackView = {
        let verticalSecondStackView = UIStackView()
        verticalSecondStackView.axis = .vertical
        verticalSecondStackView.alignment = .leading
        verticalSecondStackView.distribution = .fillEqually
        verticalSecondStackView.spacing = 5
        verticalSecondStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalSecondStackView
    }()
    
    /// Update button's image
    private var favouriteButtonImage: UIImage {
        UIImage(systemName: viewModel.movieModel.isFavourite ? "star.fill" : "star") ?? UIImage()
    }
    
    @objc private func favouriteButtonTapped() {
        /// Toggle movie's favourite status
        viewModel.toggleFavouriteStatus()
        
        /// Update button's image depending on favourite state
        navigationItem.rightBarButtonItem?.image = favouriteButtonImage
    }
}
