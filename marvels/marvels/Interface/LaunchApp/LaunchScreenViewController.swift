//
//  LaunchScreenViewController.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet private var animatedIconImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public func startAnimating() {
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: [.autoreverse,.repeat, .curveEaseInOut], animations: {
            self.animatedIconImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }) { (_) in
            
        }
        
    }

}
