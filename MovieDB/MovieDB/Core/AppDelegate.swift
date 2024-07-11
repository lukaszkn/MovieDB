//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//
//  App main entry point

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static private(set) var instance: AppDelegate! = nil
    
    /// Main window handle
    var window: UIWindow?
    
    /// Main app coordinator
    var appCoordinator: AppCoordinator?

    /// Dependencies container
    let container: Container = {
        let container = Container()
        /// Register movie database API service dependency
        container.register(MovieDBServiceProtocol.self) { _ in MovieDBService() }.inObjectScope(.container)
        /// Register local storage dependency
        container.register(LocalStorageServiceProtocol.self) { _ in LocalStorageService() }.inObjectScope(.container)
        
        return container
    }()
    
    /// App's launching point
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppDelegate.instance = self
        
        /// Create window and navigation controller
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        /// Create main app coordinator
        appCoordinator = AppCoordinator(navigationController: navigationController)
        
        /// Start app coordinator
        appCoordinator?.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

