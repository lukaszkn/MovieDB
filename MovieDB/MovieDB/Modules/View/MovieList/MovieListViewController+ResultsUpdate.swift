//
//  MovieListViewController+ResultsUpdate.swift
//  MovieDB
//
//  Created by Lukasz on 11/07/2024.
//
//  Handler for search bar text change

import UIKit

extension MovieListViewController: UISearchResultsUpdating {
    
    /// Called when the search bar's text has changed
    func updateSearchResults(for searchController: UISearchController) {
        
        /// Trim white spaces from search bar
        let trimmedString = searchController.searchBar.text!.trimmingCharacters(in: CharacterSet.whitespaces).lowercased()

        if searchController.searchBar.searchTextField.hasText {
            /// When user entered any search string, call service to get list of search results
            Task {
                await viewModel.searchMovies(query: trimmedString)
                collectionView.reloadData()
            }
        } else {
            /// When search bar text is empty, simply return all now playing movies/default list
            Task {
                await viewModel.fetchMovies()
                collectionView.reloadData()
            }
        }
    }
    
}
