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
  
  private let viewModel = ImageGridViewModel()
  private let disposeBag = DisposeBag()
  private var initialPinchScale: CGFloat = 0
  private var numberOfColumns: CGFloat = 3
  
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
    view.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognized(_:))))
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
          self?.showNetworkAlert()
        }
      }).disposed(by: disposeBag)
  }
  
  @objc func pinchRecognized(_ pinch: UIPinchGestureRecognizer) {
    if pinch.state == .began {
      initialPinchScale = pinch.scale
    } else if pinch.state == .ended {
      if pinch.scale > initialPinchScale {
        numberOfColumns -= (numberOfColumns == 1) ? 0 : 1
      } else {
        numberOfColumns += 1
      }
      
      FeedbackGenerator.selection.triggerFeedback()
      
      imageCollectionview.alpha = 0.8
      UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: UIView.AnimationOptions.curveEaseInOut, animations: {
        self.imageCollectionview.alpha = 1
        self.imageCollectionview.reloadSections(IndexSet(integer: 0))
      }, completion: nil)
    }
  }
  
  func showNetworkAlert() {
    FeedbackGenerator.error.triggerFeedback()
    let alertController = UIAlertController(title: "Network Issue", message: "Please check your connection", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "Try Again", style: .cancel, handler: { [unowned self] action in
      self.viewModel.fetchImageData()
    })
    alertController.addAction(defaultAction)
    present(alertController, animated: true)
  }
}

// MARK: UICollectionView Methods
extension ImageGridViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.currentIndex = indexPath.item
    FeedbackGenerator.selection.triggerFeedback()
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
    let width = AppConstants.getPhoneWidth/numberOfColumns - 2
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
