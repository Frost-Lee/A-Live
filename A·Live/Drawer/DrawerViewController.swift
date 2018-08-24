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
        drawerView.tabDidTapped(at: 0)
    }

}
