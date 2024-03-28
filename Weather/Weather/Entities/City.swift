//
//  City.swift
//  Weather
//
//  Created by Ivan Yepiphanov on 28/03/2024.
//

import Foundation
import MapKit

struct City: Identifiable, Hashable {
    
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
    init(mapItem: MKMapItem) {
        self.init(title: mapItem.name ?? "",
                  coordinate: mapItem.placemark.coordinate)
        
    }
}

extension CLLocationCoordinate2D: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}
