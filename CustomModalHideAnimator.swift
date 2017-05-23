//
//  CustomModalHideAnimator.swift
//  Hello Contacts
//
//  Created by kade on 5/22/17.
//  Copyright © 2017 kade. All rights reserved.
//

import UIKit

class CustomModalHideAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    let viewController: UIViewController
    
    init(withViewController viewController: UIViewController) {
        self.viewController = viewController
        
        super.init()
        
        let panGesture = UIScreenEdgePanGestureRecognizer(
            target: self,
            action: #selector(self.onEdgePan(gestureRecognizer:)))
        
        panGesture.edges = UIRectEdge.left
        viewController.view.addGestureRecognizer(panGesture)
    }
    
    func onEdgePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let panTranslation = gestureRecognizer.translation(in: viewController.view)
        let animationProgress = min(max(panTranslation.x / 200, 0.0), 1.0)
        
        switch gestureRecognizer.state {
        case .began:
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            update(animationProgress)
            break
        case .ended:
            if animationProgress < 0.5 {
                cancel()
            } else {
                finish()
            }
            break
        default:
            cancel()
            break
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(
            forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(
                forKey: UITransitionContextViewControllerKey.to) else {
                    return
        }
        
        let transitionContainer = transitionContext.containerView
        
        transitionContainer.addSubview(toViewController.view)
        transitionContainer.addSubview(fromViewController.view)
        
        let animationTiming = UISpringTimingParameters(
            dampingRatio: 0.8,
            initialVelocity: CGVector(dx: 1, dy: 0))
        
        let animator = UIViewPropertyAnimator(
            duration: transitionDuration(using: transitionContext),
            timingParameters: animationTiming)
        
        animator.addAnimations {
            var transform = CGAffineTransform.identity
            transform = transform.concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            transform = transform.concatenating(CGAffineTransform(translationX: 0, y: -200))
            
            fromViewController.view.transform = transform
            fromViewController.view.alpha = 0
        }
        
        animator.addCompletion { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        animator.startAnimation()
    }
}


























