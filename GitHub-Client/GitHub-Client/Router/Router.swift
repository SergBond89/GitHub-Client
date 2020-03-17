//
//  Router.swift
//  GitHub-Client
//
//  Created by Sergey on 2/20/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? {get set}
    var assemblyBuilder: AssemblyBuilderProtocol? {get set}
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(login: String)
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol){
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let usersListViewController = assemblyBuilder?.createUsersListModule(router: self) else { return }
            navigationController.viewControllers = [usersListViewController]
        }
    }
    
    func showDetail(login: String) {
        if let navigationController = navigationController {
            guard let detailUserViewController = assemblyBuilder?.createDetailUserModule(login: login, router: self) else { return }
            navigationController.pushViewController(detailUserViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}
