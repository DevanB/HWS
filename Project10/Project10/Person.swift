//
//  Person.swift
//  Project10
//
//  Created by Devan Beitel on 8/30/16.
//  Copyright © 2016 Devan Beitel. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

}
