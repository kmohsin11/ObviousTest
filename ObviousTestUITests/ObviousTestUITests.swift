//
//  ObviousTestUITests.swift
//  ObviousTestUITests
//
//  Created by MK on 16/11/22.
//

import XCTest
import RxSwift
import RxCocoa
@testable import ObviousTest

final class ObviousTestUITests: XCTestCase {
  func testTransitionToDetailsScreen() {
    let app = XCUIApplication()
    app.launchArguments.append(AppConstants.TextConstants.uiTesting.rawValue)
    app.launch()
    let viewModel = ImageGridViewModel()
    let sessionManager = MockAPIOperationSession(error: nil, responseFileName: "ImageDataCorrectResponse")
    viewModel.fetchImageData(with: sessionManager)
    let collectionView = app.collectionViews.firstMatch
    for i in 0..<collectionView.cells.count {
      let cell = collectionView.cells.element(boundBy: i)
      cell.tap()
      if let data = viewModel.imageData.value {
        let viewData = data[i]
        XCTAssertEqual(app.staticTexts[viewData.title].label, viewData.title)
        app.navigationBars.buttons.firstMatch.tap()
      } else {
        XCTFail()
      }
    }
  }
}
