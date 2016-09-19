//
//  Capital.swift
//  Project19
//
//  Created by Devan Beitel on 9/18/16.
//  Copyright © 2016 Devan Beitel. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title  = title
        self.coordinate = coordinate
        self.info = info
    }
}
