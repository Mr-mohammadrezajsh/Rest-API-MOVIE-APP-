//
//  Reusable.swift
//  Bapook
//
//  Created by Hooma7n on 1/22/23.
//

import UIKit

// MARK: - Reusable Protocol
public protocol Reusable {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

// MARK: - Reusable Extension
public extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
