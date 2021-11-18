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
        
        tableView.register(ListingCell.self, forCellReuseIdentifier: "ListingCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        //TODO Subscribe to view model & request data
        ServerManager.instance.get(endpoint: Endpoints.LatestListings, completionHandler: {(res: ListingResponse?, err) in
            
            if err != nil {
                //Todo display alert
                print(err?.message)
            }
            
            guard let tableViewData = res?.List.map({
                ListingViewModel(
                    iconUrl: $0.PictureHref,
                    headerViewData: ListingViewModel.TextViewData(subtitle: $0.Region, title: $0.Title),
                    footerViewData: ListingViewModel.TextViewData(subtitle: $0.HumanReadableReserveState, title: $0.PriceDisplay))
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
