//
//  HomeTableViewCell.swift
//  DeltatreAssignment
//
//  Created by Ishwar on 01/05/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionViewLayout = CollectionViewCustomFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Properties
    
    static let identifier = "HomeTableViewCell"
    
    private var pictures: [UIImage?] = []

        
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
}

// MARK: - Configure Views

extension HomeTableViewCell {
    
    private func configureViews() {
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? CollectionViewCustomFlowLayout {
            layout.delegate = self
        }
    }
}

// MARK: - Configure Cell

extension HomeTableViewCell {
    
    func configure(_ pictures: [UIImage?]) {
        
        self.pictures = pictures
    }
}

// MARK: - Collection View Data Source

extension HomeTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        cell.configure(pictures[indexPath.item])
        return cell
    }
}

// MARK: - Collection View Custom Flow Layout Delegate

extension HomeTableViewCell: CollectionViewCustomFlowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, widthForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        pictures[indexPath.item]?.size.width ?? 0
    }
}
