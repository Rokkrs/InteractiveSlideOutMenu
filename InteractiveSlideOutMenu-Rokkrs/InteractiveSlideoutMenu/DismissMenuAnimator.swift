//
//  DismissMenuAnimator.swift
//  InteractiveSlideoutMenu
//
//  Created by Oscar on 3/20/17.
//  Copyright © 2017 Thorn Technologies, LLC. All rights reserved.
//

import Foundation
import UIKit

class DismissMenuAnimator : NSObject {
}

extension DismissMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let snapshot = containerView.viewWithTag(MenuHelper.snapshotNumber)
            else {
                return
        }
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                // 2
                snapshot.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
        },
            completion: { _ in
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if didTransitionComplete {
                    // 3
                    containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
                    snapshot.removeFromSuperview()
                }
                transitionContext.completeTransition(didTransitionComplete)
        }
        )
    }
}
