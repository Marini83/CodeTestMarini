//
//  Addresses.swift
//  CodeTestMarinRusi
//
//  Created by Marin Rusi on 2018-12-21.
//  Copyright © 2018 Marin Rusi. All rights reserved.
//

import Foundation
import RealmSwift

class Emails: Object{
   // @objc dynamic var email: [String] = []
     var emails = List<String>()
}

