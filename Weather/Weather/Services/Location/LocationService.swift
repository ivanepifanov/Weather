//
//  LocationService.swift
//  Weather
//
//  Created by Ivan Yepiphanov on 27/03/2024.
//

import Foundation
import CoreLocation

public final class LocationService: NSObject, LocationServiceProtocol {

    @Published public var location: CLLocationCoordinate2D?
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private var updateLocationCompletionBlocks = [((UpdateLocationResult) -> Void)]()
    private var mainUpdateLocationCompletionBlock: ((UpdateLocationResult) -> Void)?
    
    public override init() {
        super.init()
    }
    
    public func updateLocation() async throws -> CLLocationCoordinate2D {
        try await withUnsafeThrowingContinuation { [weak self] c in
            
            self?.updateLocation { result in
                switch result {
                case .failure(let error):
                    c.resume(throwing: error)
                case .success(let status):
                    c.resume(returning: status)
                }
            }
        }
    }
    
}

public extension LocationService {
    enum UpdateLocationResult {
        case success(location: CLLocationCoordinate2D)
        case failure(error: Error)
    }
    
    func updateLocation(completion: @escaping ((UpdateLocationResult) -> Void)) {
        updateLocationCompletionBlocks.append(completion)
        
        guard updateLocationCompletionBlocks.count == 1 else { return }
        
        mainUpdateLocationCompletionBlock = { [weak self] result in
            for completion in self?.updateLocationCompletionBlocks ?? [] {
                completion(result)
            }
            self?.updateLocationCompletionBlocks.removeAll()
            self?.mainUpdateLocationCompletionBlock = nil
        }
        locationManager.requestLocation()
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    public enum UpdateLocationError: Error, Hashable {
        case emptyLocations
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            self.location = location
            mainUpdateLocationCompletionBlock?(.success(location: location))
        } else {
            mainUpdateLocationCompletionBlock?(.failure(error: UpdateLocationError.emptyLocations))
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        mainUpdateLocationCompletionBlock?(.failure(error: error))
    }
    
}
