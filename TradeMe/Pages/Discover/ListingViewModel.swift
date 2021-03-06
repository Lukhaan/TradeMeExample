//
//  Listing.swift
//  TradeMe
//
//  Created by Lucan McIver on 17/11/21.
//

import Foundation
import UIKit

struct ListingViewModel {
    let iconUrl: String?
    let headerViewData: TextViewData
    let leftFooterViewData: TextViewData
    let rightFooterViewData: TextViewData
    
    struct TextViewData {
        let subtitle: String?
        let title: String
    }
}
