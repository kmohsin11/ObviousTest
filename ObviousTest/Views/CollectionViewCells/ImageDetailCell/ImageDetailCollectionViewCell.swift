//
//  ImageDetailCollectionViewCell.swift
//  ObviousTest
//
//  Created by MK on 17/11/22.
//

import UIKit

class ImageDetailCollectionViewCell: UICollectionViewCell, ReusableView {
  
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var detailImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    scrollView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 60, right: 0)
  }
  
  func setupView(_ data: ImageData) {
    detailImageView.kf.setImage(with: URL(string: data.url ?? ""))
    titleLabel.text = data.title
    descriptionLabel.text = data.explanation
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    detailImageView.image = nil
    titleLabel.text = nil
    descriptionLabel.text = nil
  }

}
