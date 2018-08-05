//
//  CurrentAlbumView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/5.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

class CurrentAlbumView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var keyPhotoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("CurrentAlbumView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        keyPhotoView.clipsToBounds = true
        keyPhotoView.layer.cornerRadius = 15
    }
    
    var album: Album! {
        didSet {
            keyPhotoView.image = ALDataManager.defaultManager.getPhoto(with: album.keyPhotoPath!)
            titleLabel.attributedText = NSAttributedString(string: album.albumTitle!, attributes:
                ALTheme.currentAlbumTitleTextAttribute)
            descriptionLabel.attributedText = NSAttributedString(string: album.albumDescription!, attributes:
                ALTheme.currentAlbumDescriptionAttribute)
        }
    }

}
