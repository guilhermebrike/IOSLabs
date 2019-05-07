//
//  SearchResultApp.swift
//  AppStore
//
//  Created by Thong Hoang Nguyen on 2019-04-29.
//  Copyright © 2019 Thong Hoang Nguyen. All rights reserved.
//

import Foundation

struct SearchResultApp: Decodable {
  let resultCount: Int
  let results: [ResultApp]
}

struct ResultApp: Decodable {
  let trackName: String
  let primaryGenreName: String
  let averageUserRating: Float?
  let artworkUrl100: String // app icon
  let screenshotUrls: [String]
}
