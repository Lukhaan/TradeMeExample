//
//  ListingCell.swift
//  TradeMe
//
//  Created by Lucan McIver on 18/11/21.
//

import Foundation
import UIKit

class ListingCell: UITableViewCell, ReusableView {
    var image = UIImageView()
    var headerSubtitle = UILabel()
    var headerTitle = UILabel()
    var footerTitle = UILabel()
    var footerSubtitle = UILabel()
    
    var data: ListingViewModel? { didSet {
        guard let data = data else { return }
        
        do {
            //Todo make async and implement cache
            //at the moment it's pretty stuttery when loading new images
            if let url = data.iconUrl {
                let myData = try Data(contentsOf: URL(string: url)!)
                let newImage = UIImage(data: myData)!
                self.image.image = newImage
            }
        } catch {
            
        }
    
        headerSubtitle.text = data.headerViewData.subtitle
        headerTitle.text = data.headerViewData.title
        footerTitle.text = data.footerViewData.title
        footerSubtitle.text = data.footerViewData.subtitle
    }}
    
    func getHeaderStackView() -> UIStackView {
        headerTitle.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        headerSubtitle.font = .systemFont(ofSize: UIFont.systemFontSize)
        
        headerTitle.tintColor = Theme.Colors.TextDark
        footerSubtitle.tintColor = Theme.Colors.TextLight
        
        let s = UIStackView(arrangedSubviews: [
            headerSubtitle,
            headerTitle,
        ])
        s.axis = .vertical
        s.alignment = .leading
        return s
    }
    
    func getFooterStackView() -> UIStackView {
        footerTitle.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        footerSubtitle.font = .systemFont(ofSize: UIFont.systemFontSize)
        
        footerTitle.tintColor = Theme.Colors.TextDark
        footerSubtitle.tintColor = Theme.Colors.TextLight
        
        let s = UIStackView(arrangedSubviews: [
            footerTitle,
            footerSubtitle,
        ])
        s.axis = .vertical
        s.alignment = .leading
        return s
    }
    
    func getTextStackView() -> UIStackView {
        let s = UIStackView(arrangedSubviews: [
            getHeaderStackView(),
            getFooterStackView(),
        ])
        s.axis = .vertical
        s.alignment = .leading
        return s
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        
        let textStackView = getTextStackView()
        textStackView.axis = .vertical
        textStackView.distribution = .equalSpacing
        
        let stackView = UIStackView(arrangedSubviews: [
            image,
            textStackView,
        ])
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95).isActive = true
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.contentMode = .left
        stackView.spacing = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
