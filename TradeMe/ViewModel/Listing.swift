//
//  Listing.swift
//  TradeMe
//
//  Created by Lucan McIver on 17/11/21.
//

import Foundation
import UIKit

struct ListingViewModel {
    let icon: UIImage
    let headerViewData: TextViewData
    let footerViewData: TextViewData
    
    struct TextViewData {
        let subtitle: String
        let title: String
    }
}
