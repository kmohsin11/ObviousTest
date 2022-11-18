//
//  FeedbackGenerator.swift
//  ObviousTest
//
//  Created by MK on 18/11/22.
//

import UIKit

enum FeedbackGenerator {
  case selection
  case error
  
  func triggerFeedback() {
    switch self {
    case .selection:
      let feedbackGenerator = UISelectionFeedbackGenerator()
      feedbackGenerator.prepare()
      feedbackGenerator.selectionChanged()
    case .error:
      let feedbackGenerator = UINotificationFeedbackGenerator()
      feedbackGenerator.prepare()
      feedbackGenerator.notificationOccurred(.error)
    }
  }
}
