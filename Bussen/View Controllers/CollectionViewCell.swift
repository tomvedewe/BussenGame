//
//  CollectionViewCell.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 08/08/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var cardImg: UIImageView!
    
    func configure(with img: UIImage) {
        cardImg.image = img
        flip()
    }
    
    func flip() {
        UIView.transition(with: self.contentView, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
}
