//
//  Coordinator.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
