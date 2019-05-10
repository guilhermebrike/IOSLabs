//
//  Repo.swift
//  NetworkBasics2
//
//  Created by Guilherme Wahlbrink on 2019-05-08.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import Foundation


class Repo: Decodable {
    let id: Int
    let name: String
    let full_name: String
    let clone_url: String
    let created_at: String
}
