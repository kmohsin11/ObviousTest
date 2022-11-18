//
//  ImageGridCollectionViewCell.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import UIKit
import Kingfisher
import Lottie

extension AnimationView: Placeholder {}

class ImageGridCollectionViewCell: UICollectionViewCell, ReusableView {
  
  @IBOutlet var imageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setupView(_ data: ImageData) {
    let animationView = getAnimationView()
    imageView.kf.setImage(with: URL(string: data.url ?? ""), placeholder: animationView)
  }
  
  private func getAnimationView() -> AnimationView {
    let animation = Animation.named("image-loading")
    let animationView = AnimationView()
    animationView.animation = animation
    animationView.backgroundBehavior = .pauseAndRestore
    animationView.loopMode = .loop
    animationView.play()
    return animationView
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.kf.cancelDownloadTask()
  }
}
