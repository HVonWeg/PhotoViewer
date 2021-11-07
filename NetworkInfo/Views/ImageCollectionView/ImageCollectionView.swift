//
//  ImageCollectionView.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 07.11.21.
//

import UIKit

class ImageCollectionView: UICollectionView {
    
    private let lineSpacing: CGFloat = 4
    
    private lazy var viewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = lineSpacing
        // TODO: calculate best size for itemSize
        layout.itemSize = CGSize(width: 66, height: 66)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 10)
        return layout
    }()
    
    var models = [PhotoModel]() {
        didSet {
            self.reloadData()
        }
    }

    // MARK: - Livecyle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = true
        self.isPagingEnabled = false
        self.dataSource = self
        self.register(UINib(nibName: ImageCollectionViewCell.reuseIdentifier, bundle: nil),
                      forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        self.collectionViewLayout = viewLayout
    }
}

// MARK: - UICollectionViewDataSource

extension ImageCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.models[indexPath.row]
        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath)
        if let viewCell = viewCell as? ImageCollectionViewCell {
            viewCell.configure(withPhotoModel: model)
        }
        
        return viewCell
    }
}
