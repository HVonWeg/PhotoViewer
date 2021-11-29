//
//  ImageService.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 07.11.21.
//

import UIKit

typealias FetchImageResult = (Result<FetchedImageData, Error>) -> Void

// MARK: - FetchedImageData

struct FetchedImageData {
    var image: UIImage
    var token: UUID? = nil
    var isCached = false
}

// MARK: - FetchedImageError

struct FetchedImageError: Error {
    var error: Error
    var token: UUID? = nil
}

// MARK: - ImageService

class ImageService {
    
    // Single instance
    static let sharedInstance = ImageService()
    
    // Private vars
    private let imageCache = NSCache<NSString, UIImage>()
    private var runningRequests = [UUID: URLSessionDataTask]()
    private let serialQueue = DispatchQueue(label: "de.herised.runningRequestHandler")
    
    // MARK: - Fetch Images
    
    @discardableResult
    func fetchImage(url: String, completion: @escaping FetchImageResult) -> UUID? {

        let cacheKey = url as NSString
        
        // Try to get image from cache
        if let image = imageCache.object(forKey: cacheKey) {
            completion(.success(FetchedImageData(image: image, isCached: true)))
            return nil
        }
        
        // Trigger new request
        guard let url = URL(string: url) else {
            completion(.failure(FetchError.badURL))
            return nil
        }
        let token = UUID()
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            
            defer { self.removeFromRunningRequests(uuid: token) }
            
            if let error = error {
                completion(.failure(FetchedImageError(error: error, token: token)))
            } else {
                guard let data = data, let image = UIImage(data: data) else {
                    completion(.failure(FetchError.badImage))
                    return
                }
                self.imageCache.setObject(image, forKey: cacheKey)
                completion(.success(FetchedImageData(image: image, token: token)))
            }
        }
        task.resume()
        
        addToRunningRequests(uuid: token, task: task)
        
        return token
    }
    
    // MARK: - Handle Running Requests
    
    func cancleLoading(_ uuid: UUID?) {
        if let uuid = uuid {
            removeFromRunningRequests(uuid: uuid)
        }
    }
    
    private func removeFromRunningRequests(uuid: UUID) {
        serialQueue.async {
            self.runningRequests[uuid]?.cancel()
            self.runningRequests.removeValue(forKey: uuid)
        }
    }
    
    private func addToRunningRequests(uuid: UUID, task: URLSessionDataTask) {
        serialQueue.async {
            self.runningRequests[uuid] = task
        }
    }
}
