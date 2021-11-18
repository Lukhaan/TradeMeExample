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
    var leftFooterTitle = UILabel()
    var leftFooterSubtitle = UILabel()
    var rightFooterTitle = UILabel()
    var rightFooterSubtitle = UILabel()
    
    var headerStackView: UIStackView?
    var footerStackView: UIStackView?
    
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
        leftFooterTitle.text = data.leftFooterViewData.title
        leftFooterSubtitle.text = data.leftFooterViewData.subtitle
        rightFooterTitle.text = data.rightFooterViewData.title
        rightFooterSubtitle.text = data.rightFooterViewData.subtitle
    }}
    
    func getHeaderStackView() -> UIStackView {
        headerTitle.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        headerSubtitle.font = .systemFont(ofSize: UIFont.systemFontSize)
        
        headerTitle.tintColor = Theme.Colors.TextDark
        headerSubtitle.tintColor = Theme.Colors.TextLight
        
        let s = UIStackView(arrangedSubviews: [
            headerSubtitle,
            headerTitle,
        ])
        s.axis = .vertical
        s.alignment = .leading
        return s
    }
    
    func getFooterStackView() -> UIStackView {
        leftFooterTitle.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        leftFooterSubtitle.font = .systemFont(ofSize: UIFont.systemFontSize)
        
        leftFooterTitle.tintColor = Theme.Colors.TextDark
        leftFooterSubtitle.tintColor = Theme.Colors.TextLight
        
        let leftFooter = UIStackView(arrangedSubviews: [
            leftFooterTitle,
            leftFooterSubtitle,
        ])
        leftFooter.axis = .vertical
        leftFooter.alignment = .leading
        
        rightFooterTitle.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        rightFooterSubtitle.font = .systemFont(ofSize: UIFont.systemFontSize)
        
        rightFooterTitle.tintColor = Theme.Colors.TextDark
        rightFooterSubtitle.tintColor = Theme.Colors.TextLight
        
        let rightFooter = UIStackView(arrangedSubviews: [
            rightFooterTitle,
            rightFooterSubtitle,
        ])
        rightFooter.axis = .vertical
        rightFooter.alignment = .trailing
        
        let footerStackView = UIStackView()
        footerStackView.addArrangedSubview(leftFooter)
        footerStackView.addArrangedSubview(rightFooter)
        footerStackView.axis = .horizontal
        footerStackView.distribution = .equalCentering
        return footerStackView
    }
    
    func getTextStackView() -> UIStackView {
        headerStackView = getHeaderStackView()
        footerStackView = getFooterStackView()
        
        let s = UIStackView(arrangedSubviews: [
            headerStackView!,
            footerStackView!
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
        image.backgroundColor = .lightGray
        
        let textStackView = getTextStackView()
        textStackView.axis = .vertical
        textStackView.distribution = .equalCentering
        
        let stackView = UIStackView(arrangedSubviews: [
            image,
            textStackView,
        ])
        addSubview(stackView)
        
        footerStackView?.translatesAutoresizingMaskIntoConstraints = false
        footerStackView?.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        
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
