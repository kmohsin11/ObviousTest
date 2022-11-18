//
//  ImageDetailsViewController.swift
//  ObviousTest
//
//  Created by MK on 17/11/22.
//

import UIKit
import Kingfisher
import Hero

class ImageDetailsViewController: UIViewController {
  
  @IBOutlet var imageDetailCollectionView: UICollectionView!
  private let viewModel: ImageGridViewModel
  
  init(_ vm: ImageGridViewModel) {
    viewModel = vm
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    isHeroEnabled = true
    imageDetailCollectionView.delegate = self
    imageDetailCollectionView.dataSource = self
    imageDetailCollectionView.register(UINib(nibName: ImageDetailCollectionViewCell.reuseIdentifier, bundle: .main), forCellWithReuseIdentifier: ImageDetailCollectionViewCell.reuseIdentifier)
    view.layoutIfNeeded()
    let rect = CGRect(x: CGFloat(viewModel.currentIndex) * AppConstants.getPhoneWidth + 15, y: 0, width: AppConstants.getPhoneWidth, height: view.bounds.height)
    imageDetailCollectionView.scrollRectToVisible(rect, animated: false)
  }
}

// MARK: UICollectionView Methods
extension ImageDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: AppConstants.getPhoneWidth, height: view.bounds.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.imageData.value?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageDetailCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageDetailCollectionViewCell
    if let data = viewModel.imageData.value, data.indices.contains(indexPath.item) {
      let imageData = data[indexPath.item]
      cell.setupView(imageData)
    }
    return cell
  }
}
