//
//  Extensions.swift
//  TradeMe
//
//  Created by Lucan McIver on 17/11/21.
//

import Foundation
import UIKit

extension UIColor {
    ///Initialize a color using rgb values
    //Useful because UIKit by default has an initializer that takes in a fraction of 1 so it just saves us a bit of conversion.
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    ///Takes in a hex color in the format 0xRRGGBB
    convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
    }
}

extension UIView {
    func addAction(action :@escaping () -> Void) {
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapRecogniser)
     }
    
    class ClickListener: UITapGestureRecognizer {
        var onClick : (() -> Void)?
    }
    
    @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
}

extension UIViewController {
    func showToast(message : String) {
        let frameWidth = self.view.frame.width * 0.8
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - frameWidth / 2, y: self.view.frame.size.height * 0.8, width: frameWidth, height: 60))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

public protocol ReusableView {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ : T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        register(T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}
