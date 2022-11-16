//
//  ViewController.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import UIKit

class ImageGridViewController: UIViewController {
  
  @IBOutlet var imageCollectionview: UICollectionView!
  
  let viewModel = ImageGridViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    viewModel.fetchImageData()
  }
  
  private func setupUI() {
    imageCollectionview.delegate = self
    imageCollectionview.dataSource = self
    imageCollectionview.register(ImageGridCollectionViewCell.self, forCellWithReuseIdentifier: ImageGridCollectionViewCell.reuseIdentifier)
  }
  
}

// MARK: UICollectionView Methods
extension ImageGridViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = AppConstants.getPhoneWidth/3 - 20
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageGridCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageGridCollectionViewCell
    cell.setupView("")
    return cell
  }
}
