//
//  UIImage+Extensions.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 07.11.21.
//

import UIKit

extension UIView {
    func fadeIn() {
        self.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
        }
    }
}
