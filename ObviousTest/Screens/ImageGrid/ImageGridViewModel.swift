//
//  ImageGridViewModel.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import Foundation

class ImageGridViewModel {
  func fetchImageData() {
    let operation = APIBaseOperation(ImageGridAPIRequest())
    operation.startRequest { result in
      switch result {
      case .success(let data):
        let jsonDecoder = JSONDecoder()
        do {
          let imageData = try jsonDecoder.decode([ImageData].self, from: data)
          print(imageData)
        } catch {
        }
      case .failure(_):
        print("Failure")
      }
    }
  }
}
