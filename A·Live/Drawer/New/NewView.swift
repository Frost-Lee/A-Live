//
//  NewView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/2.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

protocol NewDelegate {
    func addPhotoButtonDidTapped()
    func addAlbumButtonDidTapped()
}

class NewView: UIView {
    
    @IBOutlet weak var addPhotoButton: UIButton! {
        didSet {
            addPhotoButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var addAlbumButton: UIButton! {
        didSet {
            addAlbumButton.layer.cornerRadius = 10
        }
    }
    
    var delegate: NewDelegate?

    @IBAction func addPhotoButtonTapped(_ sender: UIButton) {
        delegate?.addPhotoButtonDidTapped()
    }
    
    @IBAction func addAlbumButtonTapped(_ sender: UIButton) {
        delegate?.addAlbumButtonDidTapped()
    }
    
}
