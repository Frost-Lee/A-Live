//
//  AlbumView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/23.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

class AlbumView: UIView {
    
    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlbumView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("AlbumView", owner: self, options: nil)
        self.addSubview(view)
    }

}
