//
//  DrawerTabView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/1.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

protocol DrawerTabDelegate {
    func tabDidTapped(at index: Int)
}

class DrawerTabView: UIView {
    
    @IBOutlet weak var newLabel: UILabel! {
        didSet {
            let labelFrame = newLabel.frame
            newSelectLockFrame = CGRect(x: (labelFrame.minX + labelFrame.maxX) / 2.0 - 50,
                                        y: 51, width: 100, height: 5)
        }
    }
    @IBOutlet weak var albumLabel: UILabel! {
        didSet {
            let labelFrame = albumLabel.frame
            albumSelectLockFrame = CGRect(x: (labelFrame.minX + labelFrame.maxX) / 2.0 - 50,
                                          y: 51, width: 100, height: 5)
        }
    }
    @IBOutlet weak var mineLabel: UILabel! {
        didSet {
            let labelFrame = mineLabel.frame
            mineSelectLockFrame = CGRect(x: (labelFrame.minX + labelFrame.maxX) / 2.0 - 50,
                                         y: 51, width: 100, height: 5)
        }
    }
    @IBOutlet weak var selectionIndicatorView: UIView!
    
    var delegate: DrawerTabDelegate?
    
    private var newSelectLockFrame: CGRect!
    private var albumSelectLockFrame: CGRect!
    private var mineSelectLockFrame: CGRect!
    private var selectedIndex: Int = 1 {
        didSet {
            UIView.animate(withDuration: 0.2, delay: 0, options:
                UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.newLabel.textColor = UIColor.black
                    self.albumLabel.textColor = UIColor.black
                    self.mineLabel.textColor = UIColor.black
                    switch self.selectedIndex {
                    case 0:
                        self.selectionIndicatorView.frame = self.newSelectLockFrame
                        self.newLabel.textColor = ALTheme.orangeColor
                    case 1:
                        self.selectionIndicatorView.frame = self.albumSelectLockFrame
                        self.albumLabel.textColor = ALTheme.orangeColor
                    case 2:
                        self.selectionIndicatorView.frame = self.mineSelectLockFrame
                        self.mineLabel.textColor = ALTheme.orangeColor
                    default:
                        break
                    }
            }, completion: nil)
        }
    }
    
    @IBAction func newButtonTapped(_ sender: UIButton) {
        if selectedIndex != 0 {
            selectedIndex = 0
            delegate?.tabDidTapped(at: 0)
        }
    }
    
    @IBAction func albumButtonTapped(_ sender: UIButton) {
        if selectedIndex != 1 {
            selectedIndex = 1
            delegate?.tabDidTapped(at: 1)
        }
    }
    
    @IBAction func mineButtonTapped(_ sender: UIButton) {
        if selectedIndex != 2 {
            selectedIndex = 2
            delegate?.tabDidTapped(at: 2)
        }
    }
    
}
