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
    @IBOutlet weak var mainScrollView: UIScrollView! {
        didSet {
            albumImageView = UIImageView(image: UIImage(named: "MyAlbums"))
            mainScrollView.contentSize = albumImageView!.bounds.size
            mainScrollView.addSubview(albumImageView!)
            mainScrollView.delegate = self
            mainScrollView.setZoomScale(mainScrollView.bounds.width / albumImageView!.bounds.width, animated: false)
        }
    }
    var albumImageView: UIImageView?
    
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

    @IBAction func beginTrackingButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: TimeInterval(0.2), delay: TimeInterval(0), options: UIView.AnimationOptions.curveEaseInOut, animations: {
            ARWindowViewController.sharedInstance.darkBackgroundBlurView.alpha = 0
            ARWindowViewController.sharedInstance.currentAlbumTitleLabel.text = "People's Daily"
        }, completion: nil)
    }
    
}


extension AlbumView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return albumImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
    }
}
