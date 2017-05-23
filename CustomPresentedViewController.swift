//
//  CustomPresentedViewController.swift
//  Hello Contacts
//
//  Created by kade on 5/22/17.
//  Copyright © 2017 kade. All rights reserved.
//

import UIKit

class CustomPresentedViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var hideAnimator: CustomModalHideAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        hideAnimator = CustomModalHideAnimator(withViewController: self)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return hideAnimator
    }
    
    func animationController(forPresentedController presented: UIViewController, presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomModalShowAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return hideAnimator
    }
    
    func onTap() {
        dismiss(animated: true, completion: nil)
    }


}
