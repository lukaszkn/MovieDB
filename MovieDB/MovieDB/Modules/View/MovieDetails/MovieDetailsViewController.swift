//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Lukasz on 11/07/2024.
//
//  This is implementation of movie details screen

import UIKit

class MovieDetailsViewController: UIViewController, Storyboardable {
    var viewModel: MovieDetailsViewModel!
    weak var coordinator: AppCoordinator?
    
    @IBOutlet var posterImage: UIView!
    @IBOutlet weak var movieDetailsStack: UIStackView!
    
    override func viewDidLoad() {
        configureView()
    }
    
    private func configureView() {
        title = viewModel.movie.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: /*isFavourite ? "star.fill" :*/ "star") ?? UIImage(),
            style: .plain,
            target: self,
            action: #selector(favouriteButtonTapped)
        )
    }
    
    @objc private func favouriteButtonTapped() {
        
    }
}
