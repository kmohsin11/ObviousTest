//
//  ImageGridCollectionViewCell.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import UIKit
import Kingfisher

class ImageGridCollectionViewCell: UICollectionViewCell, ReusableView {
  
  @IBOutlet var imageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setupView(_ data: ImageData) {
    imageView.kf.setImage(with: URL(string: data.url ?? ""))
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }
}
