//
//  NavBarIconButton.swift
//  TradeMe
//
//  Created by Lucan McIver on 18/11/21.
//

import Foundation
import UIKit

class NavBarIconButton: UIBarButtonItem {
    @objc func customAction() {
        onClick?()
    }
    
    var onClick : (() -> Void)?
    
    convenience init(icon: Icon, onClick: @escaping() -> Void) {
        self.init(image: UIImage(named: icon.rawValue), style: .plain, target: nil, action: #selector(customAction))
        self.onClick = onClick
        target = self
    }
}
