//
//  FadeEnabledBtn.swift
//  StarTrivia
//
//  Created by vagelis spirou on 11/07/2019.
//  Copyright © 2019 vagelis spirou. All rights reserved.
//

import UIKit

class FadeEnabledBtn : UIButton {
    
    override var isEnabled: Bool {
        
        
        didSet {
            
            if isEnabled {
                
                UIView.animate(withDuration: 0.2) {
                    
                    self.alpha = 1.0
                    
                }
                
            } else {
                
                UIView.animate(withDuration: 0.2) {
                    
                    self.alpha = 0.5
                    
                }
                
            }
            
        }
    }
    
}
