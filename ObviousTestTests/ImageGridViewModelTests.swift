//
//  ObviousTestTests.swift
//  ObviousTestTests
//
//  Created by MK on 16/11/22.
//

import XCTest
import RxSwift
import RxCocoa
@testable import ObviousTest

final class ImageGridViewModelTests: XCTestCase {
  
  let viewModel = ImageGridViewModel()
  let disposeBag = DisposeBag()
  
  func testSuccessResponse() {
    let sessionManager = MockAPIOperationSession(error: nil, responseFileName: "ImageDataCorrectResponse")
    viewModel.fetchImageData(with: sessionManager)
    XCTAssertNotNil(viewModel.imageData.value)
    XCTAssert(viewModel.imageData.value!.count == 3)
  }
  
  func testInvalidResponse() {
    let sessionManager = MockAPIOperationSession(error: nil, responseFileName: "ImageDataInvalidResponse")
    viewModel.fetchImageData(with: sessionManager)
    XCTAssertNil(viewModel.imageData.value)
  }
  
  func testForImageSort() {
    let sessionManager = MockAPIOperationSession(error: nil, responseFileName: "ImageDataCorrectResponse")
    viewModel.fetchImageData(with: sessionManager)
    XCTAssertNotNil(viewModel.imageData.value)
    for i in 0..<(viewModel.imageData.value!.count - 1) {
      let firstDate = viewModel.imageData.value![i].date
      let secondDate = viewModel.imageData.value![i+1].date
      XCTAssertNotNil(firstDate)
      XCTAssertNotNil(secondDate)
      XCTAssertGreaterThanOrEqual(firstDate!.timeIntervalSince1970, secondDate!.timeIntervalSince1970)
    }
  }
  
  func testNetworkFailure() throws {
    let sessionManager = MockAPIOperationSession(error: .networkFailure, responseFileName: nil)
    viewModel.fetchImageData(with: sessionManager)
    XCTAssertNil(viewModel.imageData.value)
  }
  
}
