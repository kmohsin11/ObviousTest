//
//  APIOperation.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import Foundation

protocol APIOperation {
  var request: APIRequest { get }
  var sessionManager: APIOperationSession { get }
  func startRequest(completionHandler: ((APINetworkResult)->Void)?)
}


struct APIBaseOperation: APIOperation {
  let request: APIRequest
  let sessionManager: APIOperationSession
  init(_ request: APIRequest, _ sessionManager: APIOperationSession = URLSession.shared) {
    self.request = request
    self.sessionManager = sessionManager
  }
  func startRequest(completionHandler: ((APINetworkResult)->Void)?) {
    sessionManager.startRequest(withOperation: self) { result in
      completionHandler?(result)
    }
  }
}
