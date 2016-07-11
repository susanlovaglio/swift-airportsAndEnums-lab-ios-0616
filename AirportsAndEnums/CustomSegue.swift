//
//  CustomSegue.swift
//  AirportsAndEnums
//
//  Created by Joel Bell on 7/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionFade
        
        self.sourceViewController.view.window?.layer.addAnimation(transition, forKey: kCATransitionFade)
        self.sourceViewController.presentViewController(self.destinationViewController, animated: false, completion: nil)
        
    }
}
