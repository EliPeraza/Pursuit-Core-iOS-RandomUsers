//
//  ViewController.swift
//  RandomUsers
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit

class UserFeedViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var users = [User]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    fetchUsers()
  }
  
  private func fetchUsers() {
    UserAPIClient.fetchUsers { (appError, users) in
      if let appError = appError {
        print(appError.errorMessage())
      } else if let users = users {
        self.users = users
      }
    }
  }
}

extension UserFeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
    let user = users[indexPath.row]
    cell.textLabel?.text = user.name
    cell.detailTextLabel?.text = user.jobTitle
    
    if let image = ImageHelper.shared.image(forKey: user.avatar.absoluteString as NSString) {
      cell.imageView?.image = image
    } else {
      ImageHelper.shared.fetchImage(urlString: user.avatar.absoluteString) { (appError, image) in
        if let appError = appError {
          print(appError.errorMessage())
        } else if let image = image {
          cell.imageView?.image = image
        }
      }
    }
    
    return cell
  }
}
