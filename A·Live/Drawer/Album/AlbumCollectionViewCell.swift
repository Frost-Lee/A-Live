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
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    var album: Album! {
        didSet {
            keyPhotoView.image = ALDataManager.defaultManager.getPhoto(with: album.keyPhotoPath!)
            titleLabel.text = album.albumTitle!
            descriptionLabel.text = album.albumDescription!
        }
    }
    
}
