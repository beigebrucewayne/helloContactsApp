//
//  HCContact.swift
//  Hello Contacts
//
//  Created by kade on 5/21/17.
//  Copyright © 2017 kade. All rights reserved.
//

import UIKit
import Contacts

class HCContact {
    
    private let contact: CNContact
    var contactImage: UIImage?
    
    var givenName: String {
        return contact.givenName
    }
    
    var familyName: String {
        return contact.familyName
    }
    
    var emailAddress: String {
        return String(contact.emailAddresses.first?.value ?? "--")
    }
    
    var phoneNumber: String {
        return String(contact.phoneNumbers.first?.value.stringValue ?? "--")
    }
    
    var address: String {
        let street = String(contact.postalAddresses.first?.value.street ?? "--")
        let city = String(contact.postalAddresses.first?.value.city ?? "--")
        return "\(street ?? "--"), \(city ?? "--")"
    }
    
    init(contact: CNContact) {
        self.contact = contact
    }
    
    
    func prefetchImageIfNeeded() {
        if let imageData = contact.imageData, contactImage == nil {
            contactImage = UIImage(data: imageData)
        }
    }
}
