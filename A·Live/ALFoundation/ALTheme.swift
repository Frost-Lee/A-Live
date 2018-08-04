//
//  ALTheme.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/2.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import Foundation
import UIKit

class ALTheme {
    static var orangeColor = UIColor(red: 255/255, green: 186/255, blue: 34/255, alpha: 1)
    
    static var albumTitleTextAttribute: [NSAttributedString.Key : Any] {
        let font = UIFont.systemFont(ofSize: 21.0, weight: UIFont.Weight.bold)
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.gray
        shadow.shadowBlurRadius = 3
        return [NSAttributedString.Key.font: font, NSAttributedString.Key.shadow: shadow]
    }
}
