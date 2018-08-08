//
//  AlbumCollectionViewCell.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/3.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var keyPhotoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        keyPhotoView.clipsToBounds = true
        keyPhotoView.layer.cornerRadius = 10
    }
    
    var album: Album! {
        didSet {
            keyPhotoView.image = ALDataManager.defaultManager.fetchPhoto(with: album.keyPhotoPath!)
            titleLabel.attributedText = NSAttributedString(string: album.albumTitle!, attributes:
                ALTheme.albumTitleTextAttribute)
        }
    }
    
    func highLight() {
        self.layer.borderColor = ALTheme.orangeColor.cgColor
        self.layer.borderWidth = 5
    }
    
    func dehighLight() {
        self.layer.borderWidth = 0
    }
    
}
