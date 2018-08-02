//
//  DrawerView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/1.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

class DrawerView: UIView {

    @IBOutlet weak var drawerTabView: DrawerTabView!
    @IBOutlet weak var gripperView: UIView! {
        didSet {
            gripperView.layer.cornerRadius = 2.5
            gripperView.backgroundColor = UIColor(red: 195/255, green: 198/255, blue: 196/255, alpha: 1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDrawerTabView()
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
    }

}
