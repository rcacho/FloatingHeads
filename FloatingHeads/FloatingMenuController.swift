//
//  FloatingMenuController.swift
//  FloatingHeads
//
//  Created by ricardo antonio cacho on 2015-08-05.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

import UIKit
import QuartzCore

enum Direction {
    case Up
    case Left
}

protocol FloatingMenuDelegate {
    
    func closeButtonSelected()
    func menuButtonSelected()
}

class FloatingMenuController: UIViewController {
    
    let buttonDirection = Direction.Up
    
    let closeButton = FloatingButton(image: UIImage(named: "icon-close")!, frame: CGRectMake(0, 0, 50, 50), backgroundColor: UIColor.flatRedColor())
    
    let buttonPadding:CGFloat = 60
    
    var delegate:FloatingMenuDelegate?
    
    var buttonItems:Array<UIButton> = [UIButton]()
    
    var fromView:UIView?
    
    var blurredview:UIVisualEffectView?
    
    init() {
        buttonItems.append(FloatingButton(image: UIImage(named: "model-004")!, frame: CGRectMake(0, 0, 50, 50), backgroundColor: UIColor.flatBlueColor()))
        buttonItems.append(FloatingButton(image: UIImage(named: "model-005")!, frame: CGRectMake(0, 0, 50, 50), backgroundColor: UIColor.flatBlueColor()))
        buttonItems.append(FloatingButton(image: UIImage(named: "model-006")!, frame: CGRectMake(0, 0, 50, 50), backgroundColor: UIColor.flatBlueColor()))
        buttonItems.append(FloatingButton(image: UIImage(named: "model-007")!, frame: CGRectMake(0, 0, 50, 50), backgroundColor: UIColor.flatBlueColor()))
        
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .OverFullScreen
        modalTransitionStyle = .CrossDissolve
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        //iterate over the items in button items and add thme ot subview
        blurredview = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        
        let center = view.frame.origin
        let size = view.frame.size
        
        blurredview?.frame = CGRectMake(center.x, center.y, size.width, size.height)
        
        var vibrancyEffect = UIVibrancyEffect(forBlurEffect: UIBlurEffect())
        var vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = view.bounds
        
        closeButton.addTarget(self, action: "closeFloatingMenu", forControlEvents: UIControlEvents.TouchUpInside)
        
        configureButton()
        
        view.addSubview(blurredview!)
        blurredview!.contentView.addSubview(vibrancyEffectView)
        view.addSubview(closeButton)
        
        placeButtonsInList()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        resetButtonLocations()
    }
    
    override func viewWillAppear(animated: Bool) {
        animateAllButtons()
    }
    
    
    
    func configureButton() {
        closeButton.center = fromView!.center
    }
    
    func closeFloatingMenu() {
        delegate!.closeButtonSelected()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func menuButtonSelected() {
        delegate!.menuButtonSelected()
        
    }
    
    func placeButtonsInList() {
        var i = 1 as CGFloat
        let count = buttonItems.count - 1
        
        for index in 0...count {
            var button = buttonItems[index]
            var buttonY = closeButton.center.y - buttonPadding * i
            
            button.center = CGPointMake(closeButton.center.x, closeButton.center.y)
            view.addSubview(button)
            
            button.addTarget(self, action: "menuButtonSelected", forControlEvents: UIControlEvents.TouchUpInside)
        
            
            i++
        }
    }
    
    func resetButtonLocations() {
        let count = buttonItems.count - 1
        
        for index in 0...count {
           buttonItems[index].center = CGPointMake(closeButton.center.x, closeButton.center.y)
        }
    }
    
    func animateAllButtons() {
        let count = buttonItems.count - 1
        var buttonPlacement:CGFloat = 1
        
        for index in 0...count {
            animateButton(buttonItems[index], index: buttonPlacement)
            buttonPlacement++
        }
    }
    
    func relocateAllButtons() {
        let count = buttonItems.count - 1
        var buttonPlacement:CGFloat = 1
        
        for index in 0...count {
            relocateButton(buttonItems[index], index: buttonPlacement)
            buttonPlacement++
        }

    }
    
    func animateButton(button:UIButton, index:CGFloat) {
        let buttonYCoordinate = closeButton.center.y - buttonPadding * index
        
        let moveToPlace = CABasicAnimation()
        moveToPlace.keyPath = "position.y"
        moveToPlace.fromValue = closeButton.center.y
        moveToPlace.toValue = buttonYCoordinate
        moveToPlace.duration = 1.0
        
        let rotate = CABasicAnimation()
        rotate.keyPath = "transform.rotation"
        rotate.fromValue = 0
        rotate.toValue = M_2_PI
        rotate.duration = 1.0
        
        moveToPlace.beginTime = CACurrentMediaTime() + 0.10
        rotate.beginTime = CACurrentMediaTime() + 0.10
        
        button.layer.addAnimation(moveToPlace, forKey: "moveplaces")
        button.layer.addAnimation(rotate, forKey: "rotate")
        
        NSTimer.scheduledTimerWithTimeInterval(0.10, target: self, selector: "relocateAllButtons", userInfo:nil, repeats: false)
        
    }
    
    func relocateButton(button:UIButton, index:CGFloat) {
        let buttonYCoordinate = closeButton.center.y - buttonPadding * index

        button.center = CGPointMake(closeButton.center.x, buttonYCoordinate)
    }
}
