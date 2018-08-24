//
//  DrawerTabView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/1.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

protocol DrawerTabDelegate: class {
    func tabDidTapped(at index: Int)
}

class DrawerTabView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var selectionIndicatorView: UIView!
    
    weak var delegate: DrawerTabDelegate?
    
    private var albumSelectLockFrame: CGRect!
    private var storeSelectLockFrame: CGRect!
    private var selectedIndex: Int = 0 {
        didSet {
            UIView.animate(withDuration: 0.2, delay: 0, options:
                UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.albumLabel.textColor = UIColor.black
                    self.storeLabel.textColor = UIColor.black
                    switch self.selectedIndex {
                    case 0:
                        self.selectionIndicatorView.frame = self.albumSelectLockFrame
                        self.albumLabel.textColor = ALTheme.orangeColor
                    case 1:
                        self.selectionIndicatorView.frame = self.storeSelectLockFrame
                        self.storeLabel.textColor = ALTheme.orangeColor
                    default:
                        break
                    }
            }, completion: nil)
            if MainViewController.sharedInstance.drawerPosition == .collapsed {
                MainViewController.sharedInstance.setDrawerPosition(position: .partiallyRevealed, animated: true)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("DrawerTabView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("DrawerTabView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    override func layoutSubviews() {
        albumSelectLockFrame = CGRect(x: (albumLabel.frame.minX + albumLabel.frame.maxX) / 2.0 - 50,
                                      y: 51, width: 100, height: 5)
        storeSelectLockFrame = CGRect(x: (storeLabel.frame.minX + storeLabel.frame.maxX) / 2.0 - 50,
                                     y: 51, width: 100, height: 5)
    }
    
    @IBAction func albumButtonTapped(_ sender: UIButton) {
        if selectedIndex != 0 {
            selectedIndex = 0
            delegate?.tabDidTapped(at: 0)
        }
    }
    
    @IBAction func storeButtonTapped(_ sender: UIButton) {
        if selectedIndex != 1 {
            selectedIndex = 1
            delegate?.tabDidTapped(at: 1)
        }
    }
    
}
