//
//  ContactCollectionViewCelll.swift
//  Hello Contacts
//
//  Created by kade on 5/21/17.
//  Copyright © 2017 kade. All rights reserved.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contactImage: UIImageView!
    
    // called once for every cell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contactImage.layer.cornerRadius = 25
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        contactImage.image = nil
    }

}
