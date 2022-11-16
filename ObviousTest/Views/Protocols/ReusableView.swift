//
//  ReusableView.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import Foundation

protocol ReusableView {
  associatedtype ViewData
  static var reuseIdentifier: String { get }
  func setupView(_ data: ViewData)
}

extension ReusableView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
