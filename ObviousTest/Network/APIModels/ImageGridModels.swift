//
//  ImageGridModels.swift
//  ObviousTest
//
//  Created by MK on 16/11/22.
//

import Foundation

struct ImageData: Decodable {
  var title: String
  var url: String?
  var hdurl: String?
  var date: Date?
  
  enum CodingKeys: String, CodingKey {
    case title
    case url
    case hdurl
    case date
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    url = try container.decodeIfPresent(String.self, forKey: .url)
    hdurl = try container.decodeIfPresent(String.self, forKey: .hdurl)
    if let dateString = try container.decodeIfPresent(String.self, forKey: .date) {
      let df = DateFormatter()
      df.dateFormat = "YYYY-MM-DD"
      date = df.date(from: dateString)
    }
  }
}
