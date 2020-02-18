//
//  NetworkService.swift
//  GitHub-Client
//
//  Created by Sergey on 1/27/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func loadUsersData(since: Int, completion: @escaping (Result<[User]? , Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    let baseURL = "https://api.github.com/users?since="
    
    func loadUsersData(since: Int, completion: @escaping (Result<[User]? , Error>) -> Void) {
        
        guard let url = URL(string: baseURL + String(since)) else { return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let loadedUsers = try decoder.decode([User].self, from: data)
                completion(.success(loadedUsers))
            } catch let error{
                completion(.failure(error))
            }
        }.resume()
    }
    
}
