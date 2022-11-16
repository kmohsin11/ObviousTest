//
//  ImageGridAPIRequest.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import Foundation

struct ImageGridAPIRequest: APIRequest {
  let type: APIRequestType = .get
  let url = URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json")
}
