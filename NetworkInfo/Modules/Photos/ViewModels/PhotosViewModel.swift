//
//  PhotosViewModel.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 03.11.21.
//

import Foundation

class PhotosViewModel {
    
    private let apiService = APIService()
    
    var models = [PhotoModel]()
    
    func fetchData(completion: @escaping FetchFotosResult) {
        apiService.fetchPhotos { result in
            switch result {
            case .success(let model):
                self.models = model
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
