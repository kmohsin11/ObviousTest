//
//  APIOperationSession.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import Foundation

enum APIError: Error {
  case offline
  case networkFailure
  case invalidResponse
}

typealias APINetworkResult = Result<Data, APIError>

protocol APIOperationSession {
  func startRequest( withOperation operation: APIOperation, completionHandler: ((APINetworkResult)->Void)?)
}

extension URLSession: APIOperationSession {
  func startRequest(withOperation operation: APIOperation, completionHandler: ((APINetworkResult) -> Void)?) {
    if let url = operation.request.url {
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = operation.request.type.rawValue
      urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
      let dataTask = self.dataTask(with: urlRequest) { data, response, error in
        if let _ = error {
          completionHandler?(.failure(.networkFailure))
        } else {
          if let data = data {
            completionHandler?(.success(data))
          } else {
            completionHandler?(.failure(.invalidResponse))
          }
        }
      }
      dataTask.resume()
    }
  }
}
