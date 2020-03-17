//
//  DetailUserPresenter.swift
//  GitHub-Client
//
//  Created by Sergey on 2/20/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit

protocol DetailUserPresenterProtocol: class {
    init(view: DetailUserViewProtocol, networkService: NetworkService, login: String, router: RouterProtocol)
    func getDetailUserInfo()
    func tapBackButton()
}

class DetailUserPresenter: DetailUserPresenterProtocol {
   
    weak var view: DetailUserViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var login: String
    
    required init(view: DetailUserViewProtocol, networkService: NetworkService, login: String, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.login = login
        self.router = router
        getDetailUserInfo()
    }
    
    func getDetailUserInfo() {
        networkService.loadDetailUserInfo(login: login) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let detailUser):
                    self.view?.success(user: detailUser)
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func tapBackButton() {
        router?.popToRoot()
    }
    
}


