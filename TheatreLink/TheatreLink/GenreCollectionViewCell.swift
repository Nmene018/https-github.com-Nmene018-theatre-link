//
//  GenreCollectionViewCell.swift
//  TheatreLink
//
//  Created by Umar Khalid on 12/4/20.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "GenreCollectionViewCell", bundle: nil)
    }

}
