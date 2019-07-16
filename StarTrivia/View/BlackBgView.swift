//
//  BlackBgView.swift
//  StarTrivia
//
//  Created by vagelis spirou on 09/07/2019.
//  Copyright © 2019 vagelis spirou. All rights reserved.
//

import UIKit

class BlackBgView: UIView {
    
    override func awakeFromNib() {
        
        layer.backgroundColor = BLACK_BG
        layer.cornerRadius = 10
        
    }
}

class BlackBgButton: UIButton {
    
    override func awakeFromNib() {
        
        layer.backgroundColor = BLACK_BG
        layer.cornerRadius = 10
    }
    
}
