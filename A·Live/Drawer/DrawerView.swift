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
    func shouldLaunchAlbumDetailController(with album: Album)
}

class DrawerView: UIView {

    @IBOutlet weak var drawerTabView: DrawerTabView!
    @IBOutlet weak var gripperView: UIView! {
        didSet {
            gripperView.layer.cornerRadius = 2.5
            gripperView.backgroundColor = UIColor(red: 195/255, green: 198/255, blue: 196/255, alpha: 1)
        }
    }
    @IBOutlet weak var drawerContentView: UIView!
    
    var delegate: DrawerDelegate?
    
    var newView: NewView!
    var albumView: AlbumView!
    
    private var contentViewFrame: CGRect = CGRect(x: 0, y: 69, width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height - 69)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDrawerTabView()
        setupNewView()
        setupAlbumView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawerTabView.frame = CGRect(x: 0, y: 12, width: UIScreen.main.bounds.width, height: 57)
    }
    
    private func setupDrawerTabView() {
        let nib = UINib(nibName: "DrawerTabView", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self, options: nil).first as! DrawerTabView
        drawerTabView = view
        self.addSubview(drawerTabView)
        drawerTabView.delegate = self
    }
    
    private func setupDrawerContentView(with view: UIView) {
        if drawerContentView != nil {
            drawerContentView.removeFromSuperview()
        }
        drawerContentView = view
        self.addSubview(drawerContentView)
    }
    
    private func setupNewView() {
        let nib = UINib(nibName: "NewView", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self, options: nil).first as! NewView
        view.frame = contentViewFrame
        newView = view
        newView.delegate = self
    }
    
    private func setupAlbumView() {
        let nib = UINib(nibName: "AlbumView", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self, options: nil).first as! AlbumView
        view.frame = contentViewFrame
        albumView = view
        albumView.delegate = self
    }

}


extension DrawerView: DrawerTabDelegate {
    func tabDidTapped(at index: Int) {
        switch index {
        case 0:
            setupDrawerContentView(with: newView)
        case 1:
            setupDrawerContentView(with: albumView)
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
        delegate?.shouldLaunchAlbumDetailController(with: album)
    }
}
