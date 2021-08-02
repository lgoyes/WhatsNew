//
//  ProdAPICommentsRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

struct APIComment: Decodable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}

class ProdAPICommentsRepository: APICommentsRepositoryType {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    let jsonDecoder = JSONDecoder()
    var dataTask: URLSessionDataTask?
    
    func fetchComments(postId: Int, _ callback: @escaping (Result<[Comment], FetchCommentsError>) -> ()) {
        let url = getURL(postId: postId)
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
    
    func getURL(postId: Int) -> URL {
        let path = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
        // I'm force-unwrapping this optional since I'm 100% sure this is a valid URL
        let url = URL(string: path)!
        return url
    }
    
    func processDataTask(response: (data: Data?, error: Error?), callback: (Result<[Comment], FetchCommentsError>) -> ()) {
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
            let decodedResponse = try jsonDecoder.decode([APIComment].self, from: data)
            callback(.success(decodedResponse.map({ map(apiComment: $0) }) ))
        } catch {
            callback(.failure(.unexpectedResponse))
        }
    }
    
    func map(apiComment: APIComment) -> Comment {
        return Comment(
            id: apiComment.id,
            body: apiComment.body)
    }
}
