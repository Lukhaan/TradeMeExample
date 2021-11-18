//
//  Listing.swift
//  TradeMe
//
//  Created by Lucan McIver on 17/11/21.
//

import Foundation

struct ListingResponse : Response {
    let TotalCount: Int
    let List: [ListingDataModel]
    let PageSize: Int
    let Page: Int
}

struct ListingDataModel: Mappable {
    //ToDo get field info from api documentation
    var HumanReadableReserveState: String {
        switch self.ReserveState {
        case 0:
            return "No Reserve"
        case 1:
            return "Reserve Met"
        case 2:
            return "Reserve Not Met"
        default:
            return ""
        }
    }
    let ReserveState: Int?
    let Company: String?
    let IsClassified: Bool?
    let EndDate: Date
    let Subtitle: String?
    let Category: String
    let PriceDisplay: String
    let CategoryPath: String
    let StartPrice: Double
    let PictureHref: String?
    let NoteDate: Date
    let Suburb: String
    let AsAt: Date
    let StartDate: Date
    let Title: String
    let ListingId: Int
    let PromotionId: Int?
    let MemberId: Int
    let BuyNowPrice: Double?
    let HasBuyNow: Bool?
    //Todo all data is null check what datatype comes back
//    let listingLength: Date
    let Region: String
    
    //TODO check what data comes back here too
//    let additionalData: AdditionalData
//    struct AdditionalData: Mappable {
//        let bulletPoints: [String]
//        let tags: [String]
//    }

}
