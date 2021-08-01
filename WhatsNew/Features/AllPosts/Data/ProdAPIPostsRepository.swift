//
//  ProdAPIPostsRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

struct APIPost: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ProdAPIPostsRepository: APIPostsRepositoryType {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    let jsonDecoder = JSONDecoder()
    var dataTask: URLSessionDataTask?
    
    func fetchEntries(_ callback: @escaping (Result<[Post], FetchNewPostsError>) -> ()) {
        let url = getURL()
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
    
    func getURL() -> URL {
        let path = "https://jsonplaceholder.typicode.com/posts"
        // I'm force-unwrapping this optional since I'm 100% sure this is a valid URL
        let url = URL(string: path)!
        return url
    }
    
    func processDataTask(response: (data: Data?, error: Error?), callback: (Result<[Post], FetchNewPostsError>) -> ()) {
        if let error = response.error {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            
            callback(.failure(.requestError))
            return
        }
        
        guard let data = response.data else {
            callback(.failure(.requestError))
            return
        }
        
        do {
            let decodedResponse = try jsonDecoder.decode([APIPost].self, from: data)
            callback(.success(decodedResponse.map { map(apiPost: $0) }))
        } catch {
            callback(.failure(.unexpectedResponse))
        }
    }
    
    func map(apiPost: APIPost) -> Post {
        return Post(
            id: apiPost.id,
            description: apiPost.title,
            visited: false,
            favorite: false)
    }
}
