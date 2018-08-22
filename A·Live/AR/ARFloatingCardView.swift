//
//  ARFloatingCardView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/22.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

class ARFloatingCardView: UIView {

    @IBOutlet weak var floatingCardTitleLabel: UILabel!
    
    func setupTitle(with text: String) {
        floatingCardTitleLabel.text = text
    }

}
