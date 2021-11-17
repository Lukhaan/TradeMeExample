//
//  ViewController.swift
//  TradeMe
//
//  Created by Lucan McIver on 17/11/21.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(rootViewController: DiscoverViewController(), title: "Discover", image: UIImage(named: "Discover")),
            createNavController(rootViewController: NotificationsViewController(), title: "Notifications", image: UIImage(named: "Notifications")),
            createNavController(rootViewController: WatchlistViewController(), title: "Watchlist", image: UIImage(named: "Watchlist")),
            createNavController(rootViewController: MyTradeMeViewController(), title: "My Trade Me", image: UIImage(named: "Account")),
        ]
    }
    
    fileprivate func createNavController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
}
