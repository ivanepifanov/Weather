//
//  LocationServiceProtocol.swift
//  Weather
//
//  Created by Ivan Yepiphanov on 27/03/2024.
//

import Foundation
import CoreLocation

public protocol LocationServiceProtocol: ObservableObject {
    var location: CLLocationCoordinate2D? { get }
    
    func updateLocation() async throws -> CLLocationCoordinate2D
}
