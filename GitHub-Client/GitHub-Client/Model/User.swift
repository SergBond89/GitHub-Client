//
//  User.swift
//  GitHub-Client
//
//  Created by Sergey on 1/27/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//


struct User: Decodable {
    var login: String?
    var id: Int?
    var avatarUrl: String?
}
