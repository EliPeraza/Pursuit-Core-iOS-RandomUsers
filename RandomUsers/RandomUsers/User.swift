//
//  User.swift
//  RandomUsers
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

struct User: Codable {
  let id: String
  let createdAt: String
  let name: String
  let avatar: URL
  let jobTitle: String
}
