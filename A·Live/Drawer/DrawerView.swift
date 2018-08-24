//
//  DrawerView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/1.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

protocol DrawerDelegate: class {
    func shouldLaunchAddPhotoController()
    func shouldLaunchAddAlbumController()
    func shouldBeginTracking(with album: Album)
}


class DrawerView: UIView {

    @IBOutlet var view: UIView!
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
    @IBOutlet weak var albumView: AlbumView!
    @IBOutlet weak var storeView: StoreView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("DrawerView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("DrawerView", owner: self, options: nil)
        self.addSubview(view)
    }

}


extension DrawerView: DrawerTabDelegate {
    func tabDidTapped(at index: Int) {
        switch index {
        case 0:
            albumView.isHidden = false
            storeView.isHidden = true
        case 1:
            albumView.isHidden = true
            storeView.isHidden = false
        default:
            break
        }
    }
}
