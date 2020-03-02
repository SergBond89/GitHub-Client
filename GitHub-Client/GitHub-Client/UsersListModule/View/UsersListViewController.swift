//
//  UsersListViewController.swift
//  GitHub-Client
//
//  Created by Sergey on 2/6/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit

protocol UsersListViewProtocol: class {
    func setTitle()
    func success()
    func failure(error: Error)
}

class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: UsersListPresenterProtocol!
    
    private var rowHeight: CGFloat = 100
    private let usersListTitle = "Users List"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.usersListViewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}

extension UsersListViewController {
    
    private func setupTableView() {
        loadCell()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadCell() {
        let nib = UINib(nibName: "UserslListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UsersListCell")
    }
    
    func setTitle() {
         navigationItem.title = usersListTitle
     }
    
}

extension UsersListViewController: UsersListViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        let alert = UIAlertController(title: "WARNING", message: "Error: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension UsersListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        presenter.isLastCell(indexPath: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersListCell", for: indexPath) as! UserslListTableViewCell
        presenter.configure(cell, forRow: indexPath.row)
        return cell
    }
    
}

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let login = presenter.getLogin(indexPath: indexPath)
        presenter.tapOnTheUser(login: login)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
