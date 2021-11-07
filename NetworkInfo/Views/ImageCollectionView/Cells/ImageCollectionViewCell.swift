//
//  ImagelCollectionViewCell.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 07.11.21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var token: UUID? = nil
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        ImageService.sharedInstance.cancleLoading(token)
        showIndicator()
    }
    
    func configure(withPhotoModel model: PhotoModel) {
        
        self.token = ImageService.sharedInstance.fetchImage(url: model.thumbnailUrl) { [weak self] result in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchImageData):
                    // Show loaded or cached image
                    self.hideIndicator()
                    if self.token == fetchImageData.token {
                        self.imageView.image = fetchImageData.image
                        if !fetchImageData.isCached {
                            self.imageView.fadeIn()
                        } else {
                            self.imageView.alpha = 1.0
                        }
                    }
                case .failure(let fetchedError):
                    // Show error image
                    if let error = fetchedError as? FetchedImageError {
                        if self.token == error.token {
                            self.hideIndicator()
                            self.imageView.image = UIImage(named: "imageError")
                            self.imageView.alpha = 0.2
                        }
                    }
                }
            }
        }
    }
    
    // MARK - Activity Indicator
    
    private func showIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
