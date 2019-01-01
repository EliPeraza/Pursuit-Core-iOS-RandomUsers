//
//  UserAPIClient.swift
//  RandomUsers
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

final class UserAPIClient {
  static func fetchUsers(completionHandler: @escaping(AppError?, [User]?) -> Void) {
    NetworkHelper.shared.performDataTask(endpointURLString: "http://5c2381ff5db0f6001345ff3a.mockapi.io/api/v1/users", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
      if let appError = appError {
        completionHandler(appError, nil)
      }
      guard let response = httpResponse,
        (200...299).contains(response.statusCode) else {
          let statusCode = httpResponse?.statusCode ?? -999
          completionHandler(AppError.badStatusCode("\(statusCode)"), nil)
          return
      }
      if let data = data {
        do {
          let users = try JSONDecoder().decode([User].self, from: data)
          completionHandler(nil, users)
        } catch {
          completionHandler(AppError.decodingError(error), nil)
        }
      }
    }
  }
}
