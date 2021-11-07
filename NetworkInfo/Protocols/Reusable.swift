//
//  Reusable.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 07.11.21.
//

import UIKit

// MARK: - Reusable

protocol Reusable {}

// MARK: - UICollectionViewCell

extension UICollectionViewCell: Reusable {}

extension Reusable where Self: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

