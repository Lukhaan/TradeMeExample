//
//  ServerManager.swift
//  TradeMe
//
//  Created by Lucan McIver on 17/11/21.
//

import Foundation
import SwiftyJSON
import OAuthSwift

protocol Response: Codable {}
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
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(EpochDateFormatter())
        
        oauthswift.client.get(endpoint.url, completionHandler: { result in
            switch result {
            case .success(let response):
                do {
                    try completionHandler(decoder.decode(Res.self, from: response.data), nil)
                } catch {
                    completionHandler(nil, ResponseError(statusCode: 400, message: "Failed to decode data"))
                }
                break
            case .failure(let response):
                print(response.errorCode)
                switch response.errorCode {
                default:
                    completionHandler(nil, ResponseError(statusCode: response.errorCode, message: "Oops, something went wrong"))
                }
            }
        })
    }
}
