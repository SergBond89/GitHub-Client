//
//  DetailUser.swift
//  GitHub-Client
//
//  Created by Sergey on 2/20/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit

struct DetailUser: Decodable {
    var login: String
    var id: Int
    var name: String?
    var company: String?
    var publicRepos: Int?
    var avatarUrl: String
}
