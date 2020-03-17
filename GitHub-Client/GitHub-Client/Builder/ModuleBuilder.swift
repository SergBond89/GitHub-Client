//
//  ModuleBuilder.swift
//  GitHub-Client
//
//  Created by Sergey on 2/6/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createUsersListModule(router: RouterProtocol) -> UIViewController
    func createDetailUserModule(login: String, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: AssemblyBuilderProtocol {
    
    func createUsersListModule(router: RouterProtocol) -> UIViewController {
        let view = UsersListViewController()
        let networkService = NetworkService()
        let presenter = UsersListPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailUserModule(login: String, router: RouterProtocol) -> UIViewController {
        let view = DetailUserViewController()
        let networkService = NetworkService()
        let presenter = DetailUserPresenter(view: view, networkService: networkService, login: login, router: router)
        view.presenter = presenter
        return view
    }
}
