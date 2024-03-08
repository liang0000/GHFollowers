//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Sean Allen on 2/1/20.
//  Copyright © 2020 Sean Allen. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
