//
//  EpochDateSerializationStrategy.swift
//  TradeMe
//
//  Created by Lucan McIver on 18/11/21.
//

import Foundation
import SwiftyJSON

protocol Mappable: Codable {
    init?(jsonString: JSON)
}

class EpochDateFormatter: DateFormatter {
    override public func date(from string:String) -> Date? {
        let prefix = "/Date("
        let suffix = ")/"
        
        if string.hasPrefix(prefix) && string.hasSuffix(suffix) {
            let from = string.index(string.startIndex, offsetBy: prefix.count)
            let to = string.index(string.endIndex, offsetBy: -suffix.count)

            guard let milliSeconds = Double(string[from ..< to]) else {
                return nil
            }
            return Date(timeIntervalSince1970: milliSeconds / 1000.0)
        } else {
            return nil
        }
    }
}

