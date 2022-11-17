//
//  ViewController.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import UIKit
import RxSwift
import Hero

class ImageGridViewController: UIViewController {
  
  @IBOutlet var imageCollectionview: UICollectionView!
  
  let viewModel = ImageGridViewModel()
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindObservables()
    setupUI()
    viewModel.fetchImageData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: true)
  }

  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  private func setupUI() {
    isHeroEnabled = true
    navigationController?.isHeroEnabled = true
    navigationController?.heroNavigationAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
    imageCollectionview.delegate = self
    imageCollectionview.dataSource = self
    imageCollectionview.register(UINib(nibName: ImageGridCollectionViewCell.reuseIdentifier, bundle: .main), forCellWithReuseIdentifier: ImageGridCollectionViewCell.reuseIdentifier)
  }
  
  private func bindObservables() {
    viewModel.imageData
      .observe(on: MainScheduler.instance)
      .bind (onNext: { [weak self] imageData in
        if let _ = imageData {
          self?.imageCollectionview.reloadData()
        } else {
          
        }
      }).disposed(by: disposeBag)
  }
}

// MARK: UICollectionView Methods
extension ImageGridViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.currentIndex = indexPath.item
    let vc = ImageDetailsViewController(viewModel)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = AppConstants.getPhoneWidth/3 - 2
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.imageData.value?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageGridCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageGridCollectionViewCell
    if let data = viewModel.imageData.value, data.indices.contains(indexPath.item) {
      let imageData = data[indexPath.item]
      cell.setupView(imageData)
    }
    return cell
  }
}
