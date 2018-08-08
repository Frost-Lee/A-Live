//
//  DrawerView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/1.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

protocol DrawerDelegate {
    func shouldLaunchAddPhotoController()
    func shouldLaunchAddAlbumController()
    func shouldBeginTracking(with album: Album)
}


class DrawerView: UIView {

    @IBOutlet weak var drawerTabView: DrawerTabView! {
        didSet {
            drawerTabView.delegate = self
        }
    }
    @IBOutlet weak var gripperView: UIView! {
        didSet {
            gripperView.layer.cornerRadius = 2.5
            gripperView.backgroundColor = UIColor(red: 195/255, green: 198/255, blue: 196/255, alpha: 1)
        }
    }
    @IBOutlet weak var drawerContentView: UIView!
    @IBOutlet weak var newView: NewView! {
        didSet {
            newView.delegate = self
        }
    }
    @IBOutlet weak var albumView: AlbumView! {
        didSet {
            albumView.delegate = self
        }
    }
    
    var delegate: DrawerDelegate?

}


extension DrawerView: DrawerTabDelegate {
    func tabDidTapped(at index: Int) {
        switch index {
        case 0:
            newView.isHidden = false
            albumView.isHidden = true
        case 1:
            newView.isHidden = true
            albumView.isHidden = false
            albumView.reloadAlbums()
        default:
            break
        }
    }
}


extension DrawerView: NewDelegate {
    func addPhotoButtonDidTapped() {
        delegate?.shouldLaunchAddPhotoController()
    }
    
    func addAlbumButtonDidTapped() {
        delegate?.shouldLaunchAddAlbumController()
    }
}


extension DrawerView: AlbumDelegate {
    func albumDidSelected(album: Album) {
        delegate?.shouldBeginTracking(with: album)
    }
}
