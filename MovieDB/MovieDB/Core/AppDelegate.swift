//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static private(set) var instance: AppDelegate! = nil
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    let container: Container = {
        let container = Container()
        container.register(MovieDBServiceProtocol.self) { _ in MovieDBService() }.inObjectScope(.container)
        
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppDelegate.instance = self
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        appCoordinator = AppCoordinator(navigationController: navigationController)
        
        appCoordinator?.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

