//
//  MovieListViewController.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//
//  View controller for for main movie list screen

import UIKit

class MovieListViewController: UIViewController, Storyboardable {
    var viewModel: MovieListViewModel!
    weak var coordinator: AppCoordinator?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        configureView()
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            await viewModel.fetchMovies()
            collectionView.reloadData()
        }
    }
    
    // MARK: - Private methods
    
    private func configureView() {
        title = viewModel.title
    }
    
    /// Prepare seach bar
    private func configureSearchBar() {
        searchController = UISearchController(searchResultsController: nil) // nil - display search results in the same view that you are searching
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.searchTextField.placeholder = NSLocalizedString("Enter a movie title", comment: "")
        searchController.searchBar.returnKeyType = .done

        /// Place the search bar in the navigation bar
        navigationItem.searchController = searchController
            
        /// Make the search bar always visible
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieListCollectionViewCell
        cell.updateCellContent(movieModel: viewModel.movies[indexPath.item], parentViewModel: viewModel)
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    /// Called when movie is selected from the collection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies[indexPath.item]
        
        /// Call coordilator to show movie details
        coordinator?.showMovieDetails(movieModel: selectedMovie)
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    /// Adjust some colletion view settings, use 2 columns
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        let width: CGFloat = adjustedWidth / columns
        let height: CGFloat = width * 1.7
        return CGSize(width: width, height: height)
    }
}
