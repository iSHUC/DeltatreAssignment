//
//  CollectionViewCustomFlowLayout.swift
//  DeltatreAssignment
//
//  Created by Ishwar on 01/05/22.
//

import UIKit

protocol CollectionViewCustomFlowLayoutDelegate: AnyObject {
    
    func collectionView(_ collectionView: UICollectionView, widthForImageAtIndexPath indexPath: IndexPath) -> CGFloat
}

class CollectionViewCustomFlowLayout: UICollectionViewFlowLayout {
    
    weak var delegate: CollectionViewCustomFlowLayoutDelegate?
    
    private let xPadding = 10.0
    
    // Storing each item layout attributes in collection view
    private var attributes: [UICollectionViewLayoutAttributes] = []
    
    private var contentWidth: CGFloat = 0
    
    private var contentHeight: CGFloat {
        
        collectionView?.bounds.height ?? 0
    }
    
    // Returns entire collection view's content width & content height
    override var collectionViewContentSize: CGSize {
        
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    // Calculating frame & position of each item in collection view whenever layout operation is about to happen
    override func prepare() {
        
        // Return if attributes is not empty & collection view doesn't exist
        guard
            attributes.isEmpty,
            let collectionView = collectionView
        else {
            return
        }
                
        // Array of xOffset
        var xOffset: [CGFloat] = [0]
        
        // Looping through all the items of section
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)

            // Fetching width of image at indexpath
            let photoWidth = delegate?.collectionView(collectionView, widthForImageAtIndexPath: indexPath) ?? .zero
            
            // Adding cell padding to width
            let width = photoWidth + xPadding
            
            // Creating item frame with xOffset of single row
            let frame = CGRect(x: xOffset[0], y: 0, width: width, height: contentHeight)
            
            // Creating inset frame with x-coordinate padding to get space between items
            let insetFrame = frame.insetBy(dx: xPadding, dy: 0)
            
            // Check if inset frame is finite
            guard insetFrame.maxX.isFinite else {
                return
            }
            
            // Creating attribute for each item & appending it to attributes
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            attributes.append(attribute)
            
            // Updating content width with max value between last content width & largest value of x-coordinate of item's frame
            contentWidth = max(contentWidth, frame.maxX)
            
            // Updating xOffset for single row
            xOffset[0] = xOffset[0] + photoWidth
        }
    }
    
    // Collection view calls this method to determine which items are visible
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        // Loop through the attributes and append the attribute which intersects
        for attribute in attributes {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }
}
