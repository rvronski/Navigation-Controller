//
//  AnyLocations.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 28.02.2023.
//

import UIKit
import MapKit

class AnyLocations: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var name: String
    var title: String?{
       return name
    }
    init(coordinate: CLLocationCoordinate2D, name: String) {
        self.coordinate = coordinate
        self.name = name
    }
    
}
