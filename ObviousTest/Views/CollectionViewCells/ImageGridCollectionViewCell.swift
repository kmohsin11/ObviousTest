//
//  ImageGridCollectionViewCell.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import UIKit

class ImageGridCollectionViewCell: UICollectionViewCell, ReusableView {
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setupView(_ data: String) {
    let colors: [UIColor] = [.red, .green, .blue]
    backgroundColor = colors[Int.random(in: 0...2)]
  }
}
