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
        let trimmedString = searchController.searchBar.text!.trimmingCharacters(in: CharacterSet.whitespaces).lowercased()

        if searchController.searchBar.searchTextField.hasText {
            Task {
                await viewModel.searchMovies(query: trimmedString)
                collectionView.reloadData()
            }
        } else {
            Task {
                await viewModel.fetchMovies()
                collectionView.reloadData()
            }
        }
    }
    
}
