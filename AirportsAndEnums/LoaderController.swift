//
//  LoaderController.swift
//  AirportsAndEnums
//
//  Created by Joel Bell on 7/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

import UIKit

class LoaderController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.startAnimating()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            
            self.activityIndicatorView.stopAnimating()
            self.performSegueWithIdentifier("statusSegue", sender: self)
            
        })
        
    }

}
