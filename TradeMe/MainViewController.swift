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
            createNavController(rootViewController: DiscoverViewController(), title: "Discover", icon: Icon.Search),
            createNavController(rootViewController: WatchlistViewController(), title: "Watchlist", icon: Icon.Watchlist),
            createNavController(rootViewController: MyTradeMeViewController(), title: "My Trade Me", icon: Icon.Account),
        ]
        
        tabBar.tintColor = Theme.Colors.Tasman500
    }
    
    fileprivate func createNavController(rootViewController: UIViewController, title: String, icon: Icon) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: icon.rawValue)
        rootViewController.navigationItem.title = title
        return navController
    }
}
