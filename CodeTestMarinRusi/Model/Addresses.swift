//
//  Addresses.swift
//  CodeTestMarinRusi
//
//  Created by Marin Rusi on 2018-12-21.
//  Copyright © 2018 Marin Rusi. All rights reserved.
//

import Foundation
import RealmSwift

class Addresses: Object{
    //@objc dynamic var address: String = ""
    var addresses = List<String>()
}
