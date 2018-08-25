//
//  AlbumPopView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/24.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

class AlbumPopView: UIView {
    
    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlbumPopView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("AlbumPopView", owner: self, options: nil)
        self.addSubview(view)
    }

    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: TimeInterval(0.2), delay: TimeInterval(0), options: UIView.AnimationOptions.curveEaseInOut, animations: {
            StoreView.sharedInstance.popView?.frame = CGRect(x: 0, y: UIScreen.main.bounds.height,
                                         width: UIScreen.main.bounds.width, height: 597)
            StoreView.sharedInstance.backgroundView.alpha = 0
        }, completion: nil)
        
    }
    
}
