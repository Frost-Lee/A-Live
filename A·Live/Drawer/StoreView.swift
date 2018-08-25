//
//  StoreView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/23.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

class StoreView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var storeScrollView: UIScrollView! {
        didSet {
            storeImageView = UIImageView(image: UIImage(named: "Store"))
            storeScrollView.contentSize = storeImageView!.bounds.size
            storeScrollView.addSubview(storeImageView!)
            storeScrollView.delegate = self
            storeScrollView.setZoomScale(storeScrollView.bounds.width /
                storeImageView!.bounds.width, animated: false)
        }
    }
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.alpha = 0
        }
    }
    var storeImageView: UIImageView?
    var popView: AlbumPopView?
    
    static var sharedInstance: StoreView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("StoreView", owner: self, options: nil)
        self.addSubview(view)
        StoreView.sharedInstance = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("StoreView", owner: self, options: nil)
        self.addSubview(view)
        StoreView.sharedInstance = self
    }

    @IBAction func albumButtonTapped(_ sender: UIButton) {
        popView = AlbumPopView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height,
                                             width: UIScreen.main.bounds.width, height: 597))
        self.addSubview(popView!)
        UIView.animate(withDuration: TimeInterval(0.2), delay: TimeInterval(0), options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.popView?.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 597,
                                    width: UIScreen.main.bounds.width, height: 597)
            self.backgroundView.alpha = 0.6
            }, completion: nil)
        
    }
}


extension StoreView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return storeImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
    }
}
