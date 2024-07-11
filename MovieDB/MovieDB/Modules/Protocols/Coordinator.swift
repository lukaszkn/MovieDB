//
//  Coordinator.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//
//  Coordinator protocol

import UIKit

protocol Coordinator {
    /// Optional child coordinators
    var childCoordinators: [Coordinator] { get set }
    
    /// Each coordinator needs to hold navigation controller
    var navigationController: UINavigationController { get set }

    /// Start point for each coordinator
    func start()
}
