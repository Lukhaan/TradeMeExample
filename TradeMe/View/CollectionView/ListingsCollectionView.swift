//
//  ListingsCollectionView.swift
//  TradeMe
//
//  Created by Lucan McIver on 17/11/21.
//

import Foundation
import UIKit

class ListingsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    class ListingCell: UICollectionViewCell, ReusableView {
        var imageView = UIImageView(icon: .Account)
        var headerSubtitle = UILabel()
        var headerTitle = UILabel()
        var footerTitle = UILabel()
        var footerSubtitle = UILabel()
        
        var data: ListingViewModel? { didSet {
            guard let data = data else { return }
            imageView.image = data.icon
            headerSubtitle.text = data.headerViewData.subtitle
            headerTitle.text = data.headerViewData.title
            footerTitle.text = data.footerViewData.title
            footerSubtitle.text = data.footerViewData.subtitle
        }}
        
        func getHeaderStackView() -> UIStackView {
            let s = UIStackView(arrangedSubviews: [
                headerSubtitle,
                headerTitle,
            ])
            return s
        }
        
        func getFooterStackView() -> UIStackView {
            let s = UIStackView(arrangedSubviews: [
                footerTitle,
                footerSubtitle,
            ])
            return s
        }
        
        func getTextStackView() -> UIStackView {
            let s = UIStackView(arrangedSubviews: [
                getHeaderStackView(),
                getFooterStackView(),
            ])
            return s
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            let stackView = UIStackView(arrangedSubviews: [
                imageView,
                getTextStackView()
            ])
            
            addSubview(stackView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    var data = [ListingViewModel]()
    
    func setData(newData: [ListingViewModel]) {
        data = newData
        collectionViewLayout.invalidateLayout()
        reloadData()
        layoutIfNeeded()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: ListingCell = self.dequeueReusableCell(for: indexPath) as ListingCell
        
        let data = data[indexPath.row] as ListingViewModel
        cell.data = data
        
        return cell
    }
}
