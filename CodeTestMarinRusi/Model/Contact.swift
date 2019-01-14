//
//  Contact.swift
//  CodeTestMarinRusi
//
//  Created by Marin Rusi on 2018-12-21.
//  Copyright © 2018 Marin Rusi. All rights reserved.
//

import Foundation
import RealmSwift

class RealmString: Object {
    @objc dynamic var stringValue = ""
}

class ContactBook: Object {
    @objc dynamic var name: String?
     @objc dynamic var lastName: String?
     @objc dynamic var dateOfBirth: String?
     @objc dynamic var addresses: Addresses?
     @objc dynamic var phoneNumbers: PhoneNumbers?
     @objc dynamic var emails: Emails?
    
 
   
    convenience init(name: String, lastName: String, dateOfBirth : String, addresses : Addresses, phoneNumbers : PhoneNumbers, emails : Emails) {
        print("convenience init called")
        self.init()
        self.name = name
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.addresses = addresses
        self.phoneNumbers = phoneNumbers
        self.emails = emails
    }
}
