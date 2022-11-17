//
//  ImageGridViewModel.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class ImageGridViewModel {
  
  let imageData = BehaviorRelay<[ImageData]?>(value: nil)
  var currentIndex = 0
  
  func fetchImageData() {
    let operation = APIBaseOperation(ImageGridAPIRequest())
    operation.startRequest { result in
      switch result {
      case .success(let data):
        let jsonDecoder = JSONDecoder()
        do {
          let imageData = try jsonDecoder.decode([ImageData].self, from: data)
          self.imageData.accept(imageData)
        } catch {
        }
      case .failure(_):
        self.imageData.accept(nil)
      }
    }
  }
}
