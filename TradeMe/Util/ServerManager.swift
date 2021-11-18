//
//  ServerManager.swift
//  TradeMe
//
//  Created by Lucan McIver on 17/11/21.
//

import Foundation
import SwiftyJSON
import OAuthSwift

protocol Response: Mappable {}
struct ResponseError {
    let statusCode: Int
    let message: String
}

class ServerManager {
    private init() {}
    static let instance = ServerManager()
    
    func get<Res: Response>(endpoint: Endpoint, completionHandler: @escaping (_: Res?, _: ResponseError?) -> Void) {
        
        let oauthswift = OAuth1Swift(
            consumerKey: Credentials.oAuthKey,
            consumerSecret: Credentials.oAuthsecret
        )
        
        oauthswift.client.get(endpoint.url, completionHandler: { result in
            switch result {
            case .success(let response):
                let res = JSON(response.data)
                print(res)
                completionHandler(Res(jsonString: res), nil)
                break
            case .failure(let response):
                completionHandler(nil, ResponseError(statusCode: response.errorCode, message: response.description))
                break;
            }
        })
    }
}
