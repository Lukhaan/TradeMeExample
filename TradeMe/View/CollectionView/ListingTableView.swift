//
//  ListingTableView.swift
//  TradeMe
//
//  Created by Lucan McIver on 18/11/21.
//

import Foundation
import UIKit

class ListingTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListingCell = self.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        
            let data = data[indexPath.row] as ListingViewModel
            cell.data = data
            
            return cell
    }
    
    var data = [ListingViewModel]()
    
    func setData(newData: [ListingViewModel]) {
        data = newData
        reloadData()
        layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        let cellHeight: CGFloat = UIScreen.main.bounds.width * 0.25
        
        estimatedRowHeight = cellHeight
        rowHeight = cellHeight
        
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
