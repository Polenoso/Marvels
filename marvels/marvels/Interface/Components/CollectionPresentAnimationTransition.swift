//
//  CollectionAnimationTransitioningDelegate.swift
//  marvels
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class CollectionPresentAnimationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        snapshot.frame = originFrame
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.isHidden = true
        
//        AnimationHelper.perspectiveTransform(for: containerView)
//        snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/1) {
                    snapshot.frame = finalFrame
                }
        },
            // 5
            completion: { _ in
                toVC.view.isHidden = false
                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    

}
