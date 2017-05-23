//
//  ContactDetailViewController.swift
//  Hello Contacts
//
//  Created by kade on 5/22/17.
//  Copyright © 2017 kade. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet var contactImage: UIImageView!
    @IBOutlet var contactNameLabel: UILabel!
    @IBOutlet var contactPhoneLabel: UILabel!
    @IBOutlet var contactEmailLabel: UILabel!
    @IBOutlet var contactAddressLabel: UILabel!
    
    var contact: HCContact?
    
    @IBOutlet var scrollViewBottomConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onKeyboardAppear(notification:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onKeyboardHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let contact = self.contact {
            contact.prefetchImageIfNeeded()
            contactImage.image = contact.contactImage
            contactNameLabel.text = "\(contact.givenName) \(contact.familyName)"
            contactPhoneLabel.text = contact.phoneNumber
            contactEmailLabel.text = contact.emailAddress
            contactAddressLabel.text = contact.address
        }
        
    }
    
    func onKeyboardAppear(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue, let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        scrollViewBottomConstraint.constant = keyboardFrameValue.cgRectValue.size.height
        UIView.animate(withDuration: TimeInterval(animationDuration), animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }
    
    func onKeyboardHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        scrollViewBottomConstraint.constant = 0
        UIView.animate(withDuration: TimeInterval(animationDuration), animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }

}









