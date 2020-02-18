//
//  UsersListPresenter.swift
//  GitHub-Client
//
//  Created by Sergey on 2/6/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import Foundation

protocol UsersListPresenterProtocol: class {
    init(view: UsersListViewProtocol, networkService: NetworkServiceProtocol)
    var countOfUsers: Int { get }
    func usersListViewDidLoad()
    func getUsersList()
    func configure(_ cell: UsersListCellProtocol, forRow row: Int)
    func isLastCell(indexPath: IndexPath)
}

class UsersListPresenter: UsersListPresenterProtocol {

    weak var view: UsersListViewProtocol?
    let networkService: NetworkServiceProtocol!
    private var users: [User] = []
    private var lastIndexId = 0
    
    required init(view: UsersListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getUsersList()
    }
    
    var countOfUsers: Int {
        return users.count
    }
    
    func usersListViewDidLoad() {
        view?.setTitle()
    }
    
    func getUsersList() {
        networkService.loadUsersData(since: lastIndexId) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result{
                case .success(let users):
                    self.users.append(contentsOf: users!)
                    guard let lastIndexId = users?.last?.id else { return }
                    self.lastIndexId = lastIndexId
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func isLastCell(indexPath: IndexPath) {
        if users.count > 0 {
            if indexPath.row == users.count - 1 {
                getUsersList()
            }
        }
    }
    
    func configure(_ cell: UsersListCellProtocol, forRow row: Int) {
        let login = users[row].login
        let avatarUrl = users[row].avatarUrl
        cell.setUser(login: login, avatarURL: avatarUrl)
    }
    
}
