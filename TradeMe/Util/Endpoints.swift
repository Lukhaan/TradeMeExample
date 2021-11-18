//
//  Endpoints.swift
//  TradeMe
//
//  Created by Lucan McIver on 18/11/21.
//

import Foundation

struct Endpoints {
    static var LatestListings = Endpoint(url: "https://api.tmsandbox.co.nz/v1/listings/latest.json?rows=20", requestType: .Get)
}

struct Endpoint {
    let url: String
    let requestType: RequestType
}

enum RequestType: String {
    case Get = "GET"
    case Post = "POST"
    case Put = "PUT"
    case Delete = "DELETE"
}
