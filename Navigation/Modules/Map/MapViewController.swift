//
//  MapViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 22.02.2023.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController{

    private let locationManager = CLLocationManager()
    private var lon = 0.0
    private var lat = 0.0
    private var locations = [AnyLocations]()
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location()
        setupView()
       
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
        
            self.mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        
        
        ])
    }

    private func setupMap() {
        mapView.mapType = .standard

        let center = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        addPin()
        addRoute()
    }
    
    private func addPin() {
        
        let bar: AnyLocations = AnyLocations(coordinate: CLLocationCoordinate2D(latitude: self.lat + 0.01, longitude: self.lon), name: "Bar")
        let market: AnyLocations = AnyLocations(coordinate: CLLocationCoordinate2D(latitude: self.lat - 0.002, longitude: self.lon - 0.04), name: "Market")
        let job: AnyLocations = AnyLocations(coordinate: CLLocationCoordinate2D(latitude: self.lat - 0.012, longitude: self.lon - 0.023), name: "Job")
        let home: AnyLocations = AnyLocations(coordinate: CLLocationCoordinate2D(latitude: self.lat + 0.0145, longitude: self.lon + 0.0034), name: "Home")
        let myLocation: AnyLocations = AnyLocations(coordinate: CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon), name: "My location")
        self.locations.append(bar)
        self.locations.append(market)
        self.locations.append(job)
        self.locations.append(home)
        self.locations.append(myLocation)
        mapView.addAnnotations(locations)
    }
    
    private func location() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
    }
    
    private func addRoute() {
        
        let request = MKDirections.Request()
        let sourceCoordinate = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
        request.source = MKMapItem(placemark: sourcePlaceMark)
        
        let destinationCoordinate = CLLocationCoordinate2D(latitude: self.lat + 0.01, longitude: self.lon + 0.01)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)
        request.destination = MKMapItem(placemark: destinationPlaceMark)
        
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let response else {
               return
            }
            let route = response.routes[0]
            self?.mapView.delegate = self
            self?.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
}
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = manager.location?.coordinate.latitude ?? 0
        let lon = manager.location?.coordinate.longitude ?? 0
        manager.stopUpdatingLocation()
        self.lat = lat
        self.lon = lon
        self.setupMap()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print("Can't get location")
         
    }
   
}
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = .blue
        renderer.lineWidth = 2.0
        
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? AnyLocations else { return nil }
        var viewMarker: MKMarkerAnnotationView
        let idView = "Marker"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView {
            
        }
    }
    
}
