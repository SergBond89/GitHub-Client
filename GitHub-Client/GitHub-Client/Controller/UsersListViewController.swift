//
//  UsersListViewController.swift
//  GitHub-Client
//
//  Created by Sergey on 1/27/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit
import Kingfisher

class UsersListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    
    private let myActivityIndicator = UIActivityIndicatorView(style: .medium)
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersData()
        setupTableView()
    }
    
}

extension UsersListViewController {
    
    private func loadUsersData() {
        ActivityIndicator.createActivityIndicator(activityIndicator: myActivityIndicator, view: view)
        NetworkService.loadUsersData { (users) in
            self.users = users
            DispatchQueue.main.async {
                ActivityIndicator.removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        loadCell()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadCell() {
        let nib = UINib(nibName: "UserslListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UsersListCell")
    }
    
    private func isLastCell(indexPath: IndexPath) -> Bool {
            if users.count > 1 {
                if indexPath.row == users.count - 1 {
                    return true
                }
            }
        return false
    }
}


extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isLastCell(indexPath: indexPath) {
            loadUsersData()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersListCell", for: indexPath) as! UserslListTableViewCell
        DispatchQueue.main.async {
            if let urlString = self.users[indexPath.row].avatarUrl {
                let url = URL(string: urlString)
                cell.avatarImage.kf.indicatorType = .activity
                cell.avatarImage.kf.setImage(
                    with: url,
                    placeholder: nil,
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ],
                    progressBlock: nil)
            } else {
                cell.avatarImage.image = UIImage(named: "avatar.png")
                }
            cell.loginLabel?.text = self.users[indexPath.row].login
        }
        return cell
    }
    
}
