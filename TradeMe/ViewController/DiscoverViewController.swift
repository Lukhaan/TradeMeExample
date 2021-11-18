//
//  DiscoverViewController.swift
//  TradeMe
//
//  Created by Lucan McIver on 17/11/21.
//

import Foundation
import UIKit

class DiscoverViewController: BaseViewController {
    
    var tableView = ListingTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildNavigationView()
        
        view.addSubview(tableView)
        tableView.register(ListingCell.self, forCellReuseIdentifier: "ListingCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        ServerManager.instance.get(endpoint: Endpoints.LatestListings, completionHandler: {(res: ListingResponse?, err) in
            
            if err != nil {
                let alert = UIAlertController(title: "Error", message: "\(err!.message)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            guard let tableViewData = res?.List.map({
                ListingViewModel(
                    iconUrl: $0.PictureHref,
                    headerViewData: ListingViewModel.TextViewData(subtitle: $0.Region, title: $0.Title),
                    leftFooterViewData: ListingViewModel.TextViewData(subtitle: $0.HumanReadableReserveState, title: $0.PriceDisplay),
                    rightFooterViewData: ListingViewModel.TextViewData(subtitle: $0.HasBuyNow ?? false ? "Buy Now" : "", title: $0.HasBuyNow ?? false ? "$\($0.BuyNowPrice!)0" : "")
                )
            }) else { return }
            
            self.tableView.setData(newData: tableViewData)
            self.tableView.onTap = {[weak self] (data: ListingViewModel) in
                guard let self = self else { return }
                self.showToast(message: "\(data.headerViewData.title) tapped")
            }
        })
    }
    
    func buildNavigationView() {
        let searchIcon = NavBarIconButton(icon: .Search, onClick: { [weak self] in
            guard let self = self else { return }
            self.showToast(message: "Search button tapped.")
        })
        searchIcon.tintColor = Theme.Colors.Tasman500
        
        let cartIcon = NavBarIconButton(icon: .Cart, onClick: { [weak self] in
            guard let self = self else { return }
            self.showToast(message: "Cart button tapped.")
        })
        cartIcon.tintColor = Theme.Colors.Tasman500
        
        navigationItem.rightBarButtonItems = [cartIcon, searchIcon]
    }
}
