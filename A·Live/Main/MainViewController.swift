//
//  MainViewController.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/2.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit
import Pulley

class MainViewController: PulleyViewController {
    
    static var sharedInstance: MainViewController!
    
    var previousDrawerPosition: PulleyPosition = .collapsed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainViewController.sharedInstance = self
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(getReadyForNewOrientation),
            name: UIDevice.orientationDidChangeNotification , object: nil)
        delegate = self
    }
    
    @objc private func getReadyForNewOrientation() {
        let orientation = UIDevice.current.orientation
        previousDrawerPosition = (drawerPosition != .closed) ? drawerPosition : previousDrawerPosition
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            setDrawerPosition(position: .closed, animated: true)
        } else if orientation == .portrait {
            setDrawerPosition(position: previousDrawerPosition, animated: true)
        }
    }

}
