//
//  DetailPhotoViewController.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 07.11.21.
//

import UIKit

class DetailPhotoViewController: UIViewController {
    
    private var model: PhotoModel
    
    // Quick and dirty ViewController :)
    // TODO: add error handling, StackView scrolling and all other stuff you want ...
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoTitle: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    init(model: PhotoModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func fetchData() {
        photoTitle.text = model.title
        
        ImageService.sharedInstance.fetchImage(url: model.url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedImageData):
                    self.imageView.image = fetchedImageData.image
                    if !fetchedImageData.isCached {
                        self.imageView.fadeIn()
                    }
                case .failure(_):
                    self.imageView.image = UIImage(named: "imageError")
                }
            }
        }
    }

}
