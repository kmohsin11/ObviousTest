//
//  MockAPIOperationSession.swift
//  ObviousTest
//
//  Created by MK on 18/11/22.
//

import Foundation

class MockAPIOperationSession: APIOperationSession {
  let error: APIError?
  let responseFileName: String?
  
  init(error: APIError?, responseFileName: String?) {
    self.error = error
    self.responseFileName = responseFileName
  }
  
  func startRequest(withOperation operation: APIOperation, completionHandler: ((APINetworkResult) -> Void)?) {
    if let error = error {
      completionHandler?(.failure(error))
    } else {
      if let url = Bundle(for: type(of: self)).url(forResource: responseFileName, withExtension: "json") {
        do {
          let data = try Data(contentsOf: url)
          completionHandler?(.success(data))
        } catch {
          completionHandler?(.failure(.invalidResponse))
        }
      }
    }
  }
}
