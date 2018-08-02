//
//  DrawerViewController.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/1.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {

    @IBOutlet weak var drawerView: DrawerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDrawerView()
    }
    
    private func setupDrawerView() {
        let nib = UINib(nibName: "DrawerView", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self, options: nil).first as? DrawerView
        self.drawerView = view
        drawerView.frame = self.view.bounds
        self.view.addSubview(drawerView)
        drawerView.delegate = self
    }

}


extension DrawerViewController: DrawerDelegate {
    func shouldLaunchAddPhotoController() {
        let storyboard = UIStoryboard(name: "AddPhotoViewController", bundle: Bundle.main)
        self.present(storyboard.instantiateInitialViewController()!, animated: true, completion: nil)
    }
    
    func shouldLaunchAddAlbumController() {
    }
}
