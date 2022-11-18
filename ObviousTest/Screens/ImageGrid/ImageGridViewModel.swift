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
  
  let imageData = BehaviorRelay<[ImageData]?>(value: [])
  var currentIndex = 0
  
  func fetchImageData(with sessionManager: APIOperationSession = URLSession.shared) {
    let operation = APIBaseOperation(ImageGridAPIRequest(), sessionManager)
    operation.startRequest { result in
      switch result {
      case .success(let data):
        let jsonDecoder = JSONDecoder()
        do {
          var imageData = try jsonDecoder.decode([ImageData].self, from: data)
          imageData.sort { first, second in
            (first.date ?? Date()) > (second.date ?? Date())
          }
          self.imageData.accept(imageData)
        } catch {
          self.imageData.accept(nil)
        }
      case .failure(_):
        self.imageData.accept(nil)
      }
    }
  }
}
