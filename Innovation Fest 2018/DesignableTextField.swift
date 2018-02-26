//
//  DesignableTextField.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 13/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            
            leftView = imageView
        } else {
            leftViewMode = .never
        }
    }
}
