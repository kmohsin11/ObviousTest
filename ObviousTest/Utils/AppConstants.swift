//
//  AppConstants.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import UIKit

struct AppConstants {
  static var getPhoneWidth: CGFloat {
    return UIScreen.main.bounds.width
  }
  
  static var imageCacheSize: Int {
    return 100 * 1024 * 1024
  }
  
  enum TextConstants: String {
    case uiTesting = "UITesting"
  }
}
