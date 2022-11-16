//
//  APIRequest.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import Foundation

enum APIRequestType: String {
  case get = "GET"
  case post = "POST"
}

protocol APIRequest {
  var type: APIRequestType { get }
  var url: URL? { get }
}
