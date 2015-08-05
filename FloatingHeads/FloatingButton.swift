//
//  FloatingButton.swift
//  FloatingHeads
//
//  Created by ricardo antonio cacho on 2015-08-05.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

import UIKit

class FloatingButton: UIButton {
    
    var colour:UIColor = UIColor.flatBlueColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    init(image: UIImage, frame:CGRect, backgroundColor:UIColor) {
        super.init(frame: frame)
        colour = backgroundColor
        imageView?.image = image
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setup() {
        tintColor = UIColor.flatWhiteColor()
        setBackgroundImage(colour.pixelImage, forState: .Normal)
        setBackgroundImage(UIColor.blackColor().pixelImage, forState: .Selected)
        
        layer.cornerRadius = frame.width / 2.0
        layer.masksToBounds = true
    }
    
    
    
}
