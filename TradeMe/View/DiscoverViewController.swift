//
//  DiscoverViewController.swift
//  TradeMe
//
//  Created by Lucan McIver on 17/11/21.
//

import Foundation
import UIKit

class DiscoverViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = buildNavigationView()
        self.view.addSubview(navBar)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95).isActive = true
        navBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
        
        //Subscibe to viewModel
        
        
        //Request data
    }
    
    func buildNavigationView() -> UIView {
        let spacer = UIView()
        
        let title = UILabel()
        title.text = "Browse"
        title.font = .boldSystemFont(ofSize: 17)
        
        let searchIcon = UIImageView(icon: .Search)
        searchIcon.tintColor = Theme.Colors.Tasman500
        searchIcon.addAction { [weak self] in
            guard let self = self else { return }
            self.showToast(message: "Search button tapped.")
        }
        searchIcon.heightAnchor.constraint(equalTo: searchIcon.widthAnchor).isActive = true
        
        let cartIcon = UIImageView(icon: .Cart)
        cartIcon.tintColor = Theme.Colors.Tasman500
        cartIcon.addAction { [weak self] in
            guard let self = self else { return }
            self.showToast(message: "Cart button tapped.")
        }
        cartIcon.heightAnchor.constraint(equalTo: cartIcon.widthAnchor).isActive = true
        
        let titleStackView = UIStackView(arrangedSubviews: [
            spacer, title
        ])
        titleStackView.distribution = .fillEqually
        titleStackView.alignment = .center
        
        let iconStackView = UIStackView(arrangedSubviews: [
            searchIcon, cartIcon
        ])
        iconStackView.spacing = 20
        iconStackView.alignment = .trailing
        
        let stackView = UIStackView(arrangedSubviews: [
            titleStackView,
            iconStackView
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }
}

extension UIImageView {
    convenience init(icon: Icon) {
        self.init(image: UIImage(named: icon.rawValue))
    }
}
