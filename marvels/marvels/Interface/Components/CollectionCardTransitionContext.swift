//
//  CollectionCardTransitionContext.swift
//  marvels
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class CollectionCardTransitionContext: NSObject, UIViewControllerTransitioningDelegate {
    
    let cardFrame: CGRect
    
    init(_ frame: CGRect) {
        self.cardFrame = frame
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CollectionPresentAnimationTransition(originFrame: cardFrame)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CollectionDismissAnimationTransition(destinationFrame: cardFrame)
    }
}
