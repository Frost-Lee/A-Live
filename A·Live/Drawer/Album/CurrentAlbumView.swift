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
            UIView.transition(with: keyPhotoView, duration: 0.25, options:
                UIView.AnimationOptions.transitionCrossDissolve, animations:
                {self.keyPhotoView.image = ALDataManager.defaultManager
                    .fetchPhoto(with: self.album.keyPhotoPath!)}, completion: nil)
            UIView.transition(with: titleLabel, duration: 0.25, options:
                UIView.AnimationOptions.transitionCrossDissolve, animations:
                {self.titleLabel.attributedText = NSAttributedString(string: self.album.albumTitle!, attributes:
                    ALTheme.currentAlbumTitleTextAttribute)}, completion: nil)
            UIView.transition(with: titleLabel, duration: 0.25, options:
                UIView.AnimationOptions.transitionCrossDissolve, animations:
                {self.descriptionLabel.attributedText = NSAttributedString(string: self.album.albumDescription!, attributes:
                    ALTheme.currentAlbumDescriptionAttribute)}, completion: nil)
        }
    }

}
