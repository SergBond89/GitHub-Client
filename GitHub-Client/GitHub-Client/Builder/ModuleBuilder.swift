//
//  ModuleBuilder.swift
//  GitHub-Client
//
//  Created by Sergey on 2/6/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit

protocol Builder {
    static func createUsersListVC() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createUsersListVC() -> UIViewController {
        let view = UsersListViewController()
        let networkService = NetworkService()
        let presenter = UsersListPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
