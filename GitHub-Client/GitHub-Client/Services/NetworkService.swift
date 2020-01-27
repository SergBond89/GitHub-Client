//
//  NetworkService.swift
//  GitHub-Client
//
//  Created by Sergey on 1/27/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import Foundation

class NetworkService {
    
     static var users = [User]()
     static let baseURL = "https://api.github.com/users?since="
     static var lastIndexId = 0
     
     static func loadUsersData(completion: @escaping (_ users: [User]) -> ()) {
        
         guard let url = URL(string: baseURL + String(lastIndexId)) else { return}
         URLSession.shared.dataTask(with: url) { (data, response, error) in
             if error != nil {
                 print(error?.localizedDescription ?? "")
             }
             
             guard let data = data else { return }
             do {
                 let decoder = JSONDecoder()
                 decoder.keyDecodingStrategy = .convertFromSnakeCase
                 let loadedUsers = try decoder.decode([User].self, from: data)
                 users.append(contentsOf: loadedUsers)
                 guard let lastIndexId = loadedUsers.last?.id else { return }
                 self.lastIndexId = lastIndexId
                 completion(users)
             } catch let error {
                 print(error)
             }
             }.resume()
     }
    
}
