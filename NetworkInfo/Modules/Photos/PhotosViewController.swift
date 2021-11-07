//
//  ViewController.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 03.11.21.
//

import UIKit

// https://medium.com/flawless-app-stories/mvvm-in-ios-swift-aa1448a66fb4
class PhotosViewController: UIViewController {
    
    @IBOutlet weak var imageCollectionView: ImageCollectionView!
    
    private lazy var viewModel = PhotosViewModel()

    // MARK: - Livecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        fetchData()
    }
    
    // MARK: - Handle data
    
    private func fetchData() {
        viewModel.fetchData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    self.imageCollectionView.models = models
                case .failure(let error):
                    // TODO: error handling
                    print("*** TODO: error handling: ", error)
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension PhotosViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.models[indexPath.row]
        let controller = DetailPhotoViewController(model: model)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

