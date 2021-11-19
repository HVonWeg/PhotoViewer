//
//  APIClient.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 03.11.21.
//

import Foundation


typealias FetchFotosResult = (Result<[PhotoModel], Error>) -> Void

enum FetchError: Error {
    case badURL
    case badImage
    case badResponse
    case invalidJson
}

class APIService {
    
    // MARK: URLRequests
    
    private func photosURLRequest() -> URLRequest {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        return URLRequest(url: url!)
    }
    
    // MARK: Photos
    
    func fetchPhotos(completion: @escaping FetchFotosResult) {
        let request = photosURLRequest()
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                // Parse Model
                guard let data = data else {
                    completion(.failure(FetchError.badResponse))
                    return
                }
                do {
                    let photoModels = try JSONDecoder().decode([PhotoModel].self, from: data)
                    completion(.success(photoModels))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
