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
    var storeImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("StoreView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("StoreView", owner: self, options: nil)
        self.addSubview(view)
    }

}


extension StoreView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return storeImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
    }
}
