//
//  HomeCollectionViewCell.swift
//  DeltatreAssignment
//
//  Created by Ishwar on 01/05/22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Properties
    
    static let identifier = "HomeCollectionViewCell"
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
    }
}

// MARK: - Configure Views

extension HomeCollectionViewCell {
    
    private func configureViews() {
        
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        
        configureImageView()
    }
    
    private func configureImageView() {
        
        contentView.addSubview(imageView)
    }
}

// MARK: - Configure Cell

extension HomeCollectionViewCell {
    
    func configure(_ image: UIImage?) {
        
        imageView.image = image
    }
}
