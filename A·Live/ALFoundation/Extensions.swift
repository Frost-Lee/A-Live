//
//  Extensions.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/22.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func viewImage(for size: CGSize) -> UIImage? {
        if self.frame.width != 0 && self.frame.height != 0 {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        } else {
            return nil
        }
    }
}
