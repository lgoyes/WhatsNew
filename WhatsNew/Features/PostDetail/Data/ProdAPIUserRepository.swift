//
//  ProdAPIUserRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

struct APIUser: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
}

class ProdAPIUserRepository: APIUserRepositoryType {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    let jsonDecoder = JSONDecoder()
    var dataTask: URLSessionDataTask?
    
    func fetchUser(userId: Int, _ callback: @escaping (Result<User, FetchUserError>) -> ()) {
        let url = getURL(userId: userId)
        dataTask?.cancel()
        dataTask = urlSession.dataTask(with: url) { [weak self] (data, _, error) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.processDataTask(
                    response: (data: data, error: error),
                    callback: callback)
                self.dataTask = nil
            }
        }
        dataTask?.resume()
    }
    
    func getURL(userId: Int) -> URL {
        let path = "https://jsonplaceholder.typicode.com/users/\(userId)"
        // I'm force-unwrapping this optional since I'm 100% sure this is a valid URL
        let url = URL(string: path)!
        return url
    }
    
    func processDataTask(response: (data: Data?, error: Error?), callback: (Result<User, FetchUserError>) -> ()) {
        if let error = response.error {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            
            callback(.failure(.networkError))
            return
        }
        
        guard let data = response.data else {
            callback(.failure(.networkError))
            return
        }
        
        do {
            let decodedResponse = try jsonDecoder.decode(APIUser.self, from: data)
            callback(.success(map(apiUser: decodedResponse)))
        } catch {
            callback(.failure(.unexpectedResponse))
        }
    }
    
    func map(apiUser: APIUser) -> User {
        return User(
            id: apiUser.id,
            name: apiUser.name,
            username: apiUser.username,
            email: apiUser.email,
            phone: apiUser.phone,
            website: apiUser.website)
    }
}
