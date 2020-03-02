//
//  NetworkService.swift
//  GitHub-Client
//
//  Created by Sergey on 1/27/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import Foundation

enum APIs: String {
    case users
    case repositories
}

protocol NetworkServiceProtocol {
    func loadUsersData(since: Int, completion: @escaping (Result<[User]? , Error>) -> Void)
    func loadDetailUserInfo(login: String, completion: @escaping (Result<DetailUser? , Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    let baseURL = "https://api.github.com/"
    
    func loadUsersData(since: Int, completion: @escaping (Result<[User]? , Error>) -> Void) {
        
        guard let url = URL(string: baseURL + APIs.users.rawValue) else { return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [URLQueryItem(name: "since", value: "\(since)")]
        guard let queryURL = urlComponents?.url else { return }
        
        URLSession.shared.dataTask(with: queryURL) { (data, response, error) in
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
    
    func loadDetailUserInfo(login: String, completion: @escaping (Result<DetailUser? , Error>) -> Void) {
        
        guard let url = URL(string: baseURL + APIs.users.rawValue + "/\(login)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let loadedUser = try decoder.decode(DetailUser.self, from: data)
                completion(.success(loadedUser))
            } catch let error{
                completion(.failure(error))
            }
        }.resume()
    }
    
}
