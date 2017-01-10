//
//  VerbindungTextField.swift
//  UniversalAnsteuerung
//
//  Created by UDLab on 24/12/2016.
//  Copyright © 2016 UDSoft. All rights reserved.
//

import UIKit

class VerbindungTextField: UITextField {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = UIColor(white:100/255 , alpha:1).cgColor
        self.layer.borderWidth = 2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
