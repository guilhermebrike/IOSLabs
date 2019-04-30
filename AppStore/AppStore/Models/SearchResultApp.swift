//
//  SearchResultApp.swift
//  AppStore
//
//  Created by Guilherme Wahlbrink on 2019-04-29.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import Foundation


struct SearchResultApps: Decodable {
    let resultCount: Int
    let results: [ResultApp]
}


struct ResultApp: Decodable {
    let trackName: String
    let primaryGenreName: String
}
