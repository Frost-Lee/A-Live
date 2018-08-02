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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDrawerTabView()
        setupNewView()
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
        let screenBound = UIScreen.main.bounds
        view.frame = CGRect(x: 0, y: 69, width: screenBound.width, height: screenBound.height - 69)
        newView = view
        newView.delegate = self
    }

}


extension DrawerView: DrawerTabDelegate {
    func tabDidTapped(at index: Int) {
        switch index {
        case 0:
            setupDrawerContentView(with: newView)
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
